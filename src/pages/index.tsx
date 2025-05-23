import ChatForm from "@/components/ChatForm";
import DataTable from "@/components/DataTable";
import Preloader from "@/components/Preloader";
import SqlViewer from "@/components/SqlViewer";
import GithubIcon from "@/components/icons/GithubIcon";
import Head from "next/head";
import { useState } from "react";

interface ChatResponse {
	prompt: string;
	sqlQuery: string;
	result: Record<string, string | boolean | number>[];
	error: string;
}

export default function Home() {
	const [response, setResponse] = useState<ChatResponse | null>(null);
	const [waitingResponse, setWaitingResponse] = useState(false);
	const [firstRun, setFirstRun] = useState(true);
	const [prompt, setPrompt] = useState("");

	const onPrompt = async (prompt: string) => {
		setFirstRun(false);
		setWaitingResponse(true);
		setPrompt(prompt);

		// Post value to API
		const res = await fetch("http://localhost:3000/api/chat", {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},

			body: JSON.stringify({
				query: prompt,
			}),
		});

		const data = await res.json();
		setResponse(data);
		setWaitingResponse(false);
	};

	const getSqlViewerContent = () => {
		if (response?.sqlQuery) {
			if (waitingResponse) {
				return `-- ${prompt}`;
			} else {
				return `-- ${prompt} \n${response.sqlQuery}`;
			}
		}

		if (waitingResponse) {
			return `-- ${prompt}`;
		}

		return "-- No prompt yet";
	};

	return (
		<>
			<Head>
				<title>Chat to your database</title>
				<meta name="description" content="Generated by create next app" />
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<link rel="icon" href="/favicon.ico" />
			</Head>
			<main className="text-slate-100 h-full">
				<section className="flex flex-col mx-auto max-w-7xl h-full justify-between">
					<div className="flex flex-col flex-1">
						<div className="flex justify-between items-center">
							<h1 className="text-2xl font-bold mt-6 mb-6 text-slate-300">Chat to your database</h1>
						</div>
						{response?.error && response?.error !== "" && (
							<p className="rounded-xl bg-red-500 text-white p-6 mb-8">{response.error}</p>
						)}
						<div className="relative flex flex-col flex-1 rounded-2xl bg-slate-900 overflow-hidden overflow-y-auto scrollbar-thin scrollbar-track-slate-950 scrollbar-thumb-slate-700 scrollbar-track-rounded-lg scrollbar-thumb-rounded-lg">
							{waitingResponse || firstRun ? (
								<div className="flex flex-col items-center justify-center h-full">
									{waitingResponse && (
										<Preloader backgroundColor="fill-slate-800" fillColor="fill-slate-600" />
									)}
									{firstRun && <p className="text-slate-500 mt-4">Type a prompt to get started</p>}
								</div>
							) : (
								<DataTable data={response?.result} />
							)}
						</div>
					</div>
					<div className="mb-12 mt-8">
						<div className="p-4 bg-slate-900 rounded-xl w-full mb-8">
							<SqlViewer content={getSqlViewerContent()} />
						</div>
						<div className="flex rounded-2xl flex-col relative">
							<ChatForm onPrompt={onPrompt} />
						</div>
					</div>
				</section>
			</main>
		</>
	);
}

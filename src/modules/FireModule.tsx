import { useState } from "react";
import audioPlayer from "@utils/audioPlayer";

export default function FireModule() {
  const [progress, setProgress] = useState(0);
  audioPlayer("/audio/fuego.mp3");

  function handleDrag(e: React.MouseEvent) {
    const val = Math.min(100, Math.max(0, e.clientY / window.innerHeight * 100));
    setProgress(val);
  }

  return (
    <section>
      <h3 className="text-2xl font-serif text-rojoProfundo mb-4">
        Prueba del Fuego
      </h3>
      <div
        className="h-64 bg-gradient-to-b from-rojoProfundo via-orange-500 to-gray-900 relative"
        onMouseMove={handleDrag}
      >
        <div
          className="absolute bottom-0 left-0 w-full bg-yellow-400"
          style={{ height: `${progress}%` }}
        />
      </div>
      <p className="mt-4">
        “Contener la pasión es gobernar tu propio imperio de brasas.”
      </p>
      <progress value={progress} max={100} className="w-full mt-2" />
    </section>
  );
}

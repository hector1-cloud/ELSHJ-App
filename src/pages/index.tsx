import NavBar from "@components/NavBar";
import ChapterList from "@components/ChapterList";
import Footer from "@components/Footer";

export default function Home() {
  return (
    <>
      <NavBar />
      <main className="max-w-3xl mx-auto p-4">
        <h1 className="text-4xl font-serif text-azulNoche mb-6">
          El Lenguaje Secreto de Héctor Jazziel
        </h1>
        <p className="mb-8">
          Explora gestos, piedras y pruebas divinas en una experiencia
          interactiva.
        </p>
        <ChapterList />
      </main>
      <Footer />
    </>
  );
}

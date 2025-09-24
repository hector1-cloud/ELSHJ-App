import NavBar from "@components/NavBar";
import StoneCatalog from "@components/StoneCatalog";
import Footer from "@components/Footer";

export default function Stones() {
  return (
    <>
      <NavBar />
      <main className="max-w-4xl mx-auto p-4">
        <h2 className="text-3xl font-serif text-azulNoche mb-4">
          Catálogo de Piedras con Alma
        </h2>
        <StoneCatalog />
      </main>
      <Footer />
    </>
  );
}

import { useRouter } from "next/router";
import NavBar from "@components/NavBar";
import ModuleNav from "@components/ModuleNav";
import FireModule from "@modules/FireModule";
import WaterModule from "@modules/WaterModule";
import AirModule from "@modules/AirModule";
import RevealModule from "@modules/RevealModule";

export default function ModulePage() {
  const { slug } = useRouter().query;
  let Content;
  switch (slug) {
    case "fuego":
      Content = FireModule;
      break;
    case "agua":
      Content = WaterModule;
      break;
    case "aire":
      Content = AirModule;
      break;
    case "revelacion":
      Content = RevealModule;
      break;
    default:
      Content = () => <p>Módulo no encontrado.</p>;
  }
  return (
    <>
      <NavBar />
      <ModuleNav current={slug as string} />
      <main className="max-w-3xl mx-auto p-4">
        <Content />
      </main>
    </>
  );
}

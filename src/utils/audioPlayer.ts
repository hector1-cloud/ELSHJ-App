export default function audioPlayer(src: string) {
  const audio = new Audio(src);
  audio.loop = true;
  audio.volume = 0.3;
  audio.play().catch(() => {});
}

import SegmentedProgressBar from './SegmentedProgressBar.js';

const setupElements = (mainElement, progressElements, count) => {
    const main = document.querySelector(mainElement);
    for (let i = 0; i < count; i++) {
        const bar = document.createElement('div');
        bar.classList.add('progress-bar');

        const progress = document.createElement('div');
        progress.classList.add(progressElements);

        bar.appendChild(progress);
        main.appendChild(bar);
    }
};
setupElements('.boxPercent', 'progress', 10);
const progressBar = new SegmentedProgressBar('.progress', 100);
const iframe = window.parent.document.body.querySelector(`iframe[name='${GetParentResourceName()}']`);;
iframe.style.zIndex = 9999999;
const container = document.querySelector(".container")
container.style.opacity = 0;
setTimeout(() => {
    container.style.opacity = 1;
}, 1000);
window.addEventListener('message', (event) => {
    switch (event.data.eventName) {
        case 'loadProgress':
            progressBar.updateProgress(event.data.loadFraction * 100);
            break;
        case 'onDataFileEntry':
            document.getElementById('log').textContent = event.data.name;
            break;
        default:
    }
});

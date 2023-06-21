let times = 0;
const syncDB = () => {
    times++;
    console.log('tick cada multiplo de 5 segundos ', times);
    return times;
}

module.exports = {
    syncDB
}
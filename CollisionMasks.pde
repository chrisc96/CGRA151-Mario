void generateCB() {
    PVector[] coords = {new PVector(256, 136), new PVector(336, 136), new PVector(368, 136), 
        new PVector(352, 73), new PVector(1248, 136), new PVector(1504, 72), 
        new PVector(1696, 136), new PVector(1744, 72), new PVector(1744, 136), 
        new PVector(1792, 136), new PVector(2064, 72), new PVector(2080, 72), 
        new PVector(2720, 136)
    };

    for (int i = 0; i < coords.length; i++) {
        CoinsBlock cb = new CoinsBlock(coords[i]);
        blocks.add(cb);
        coinBlocks.add(cb);
    }
}

void generateBB() {
    PVector[] coords = { new PVector(320, 136), new PVector(352, 136), new PVector(384, 136), 
        new PVector(1232, 136), new PVector(1264, 136), new PVector(1280, 72), 
        new PVector(1296, 72), new PVector(1312, 72), new PVector(1328, 72), 
        new PVector(1344, 72), new PVector(1360, 72), new PVector(1376, 72), 
        new PVector(1392, 72), new PVector(1408, 72), new PVector(1456, 72), 
        new PVector(1472, 72), new PVector(1488, 72), new PVector(1504, 136), 
        new PVector(1600, 136), new PVector(1616, 136), new PVector(1888, 136), 
        new PVector(1936, 72), new PVector(1952, 72), new PVector(1968, 72), 
        new PVector(2048, 72), new PVector(2064, 136), new PVector(2080, 136), 
        new PVector(2096, 72), new PVector(2688, 136), new PVector(2704, 136), 
        new PVector(2736, 136)
    };
    for (int i = 0; i < coords.length; i++) {
        BrickBlock bb = new BrickBlock(coords[i]);
        blocks.add(bb);
        brickBlocks.add(bb);
    }
}

void generateSB() {
    PVector[] coords = { new PVector(2144, 184), new PVector(2160, 184), new PVector(2176, 184), new PVector(2192, 184), new PVector(2160, 168), 
        new PVector(2176, 168), new PVector(2192, 168), new PVector(2176, 152), new PVector(2192, 152), new PVector(2192, 136), 

        new PVector(2240, 136), new PVector(2240, 152), new PVector(2256, 152), new PVector(2240, 168), new PVector(2256, 168), 
        new PVector(2272, 168), new PVector(2240, 184), new PVector(2256, 184), new PVector(2272, 184), new PVector(2288, 184), 

        new PVector(2368, 184), new PVector(2384, 184), new PVector(2400, 184), new PVector(2416, 184), new PVector(2432, 184), 
        new PVector(2384, 168), new PVector(2400, 168), new PVector(2416, 168), new PVector(2432, 168), new PVector(2400, 152), 
        new PVector(2416, 152), new PVector(2432, 152), new PVector(2416, 136), new PVector(2432, 136), 

        new PVector(2480, 136), new PVector(2480, 152), new PVector(2496, 152), new PVector(2480, 168), new PVector(2496, 168), 
        new PVector(2512, 168), new PVector(2480, 184), new PVector(2496, 184), new PVector(2512, 184), new PVector(2528, 184), 

        new PVector(2896, 184), new PVector(2912, 184), new PVector(2928, 184), new PVector(2944, 184), new PVector(2960, 184), 
        new PVector(2976, 184), new PVector(2992, 184), new PVector(3008, 184), new PVector(3024, 184), new PVector(2912, 168), 
        new PVector(2928, 168), new PVector(2944, 168), new PVector(2960, 168), new PVector(2976, 168), new PVector(2992, 168), 
        new PVector(3008, 168), new PVector(3024, 168), new PVector(2928, 152), new PVector(2944, 152), new PVector(2960, 152), 
        new PVector(2976, 152), new PVector(2992, 152), new PVector(3008, 152), new PVector(3024, 152), new PVector(2944, 136), 
        new PVector(2960, 136), new PVector(2976, 136), new PVector(2992, 136), new PVector(3008, 136), new PVector(3024, 136), 
        new PVector(2960, 120), new PVector(2976, 120), new PVector(2992, 120), new PVector(3008, 120), new PVector(3024, 120), 
        new PVector(2976, 104), new PVector(2992, 104), new PVector(3008, 104), new PVector(3024, 104), new PVector(2992, 88), 
        new PVector(3008, 88), new PVector(3024, 88), new PVector(3008, 72), new PVector(3024, 72), 

        new PVector(3168, 184)
    };
    for (int i = 0; i < coords.length; i++) {
        StepBlock sb = new StepBlock(coords[i]);
        blocks.add(sb);
        stepBlocks.add(sb);
    }
}

void generateFloorT() {
    floorTiles.add(new FloorTile(new PVector(0, 200), 1104, 23));
    floorTiles.add(new FloorTile(new PVector(1136, 200), 240, 23));
    floorTiles.add(new FloorTile(new PVector(1424, 200), 1024, 23));
    floorTiles.add(new FloorTile(new PVector(2240, 200), 208, 23));
    floorTiles.add(new FloorTile(new PVector(2480, 200), 912, 23));
}

void generateFallT() {
    fallTiles.add(new FallTile(new PVector(1104, 200), 32, 23));
    fallTiles.add(new FallTile(new PVector(1376, 200), 48, 23));
    fallTiles.add(new FallTile(new PVector(2448, 136), 32, 88));
}

void generatePipes() {
    pipes.add(new Pipe(new PVector(448,168), 32,32));
    pipes.add(new Pipe(new PVector(608,152), 32,48));
    pipes.add(new Pipe(new PVector(736,136), 32,64));
    pipes.add(new Pipe(new PVector(912,136), 32,64));
    pipes.add(new Pipe(new PVector(2608,168),32,32));
    pipes.add(new Pipe(new PVector(2864,168),32,32));
}

void generateFlowers() {
    int count = 0;
    List<PVector> flowerCoords = new ArrayList<PVector>();

    flowerCoords.add(new PVector(456,168));
    flowerCoords.add(new PVector(616,152));
    flowerCoords.add(new PVector(742,136));
    flowerCoords.add(new PVector(920,136));
    flowerCoords.add(new PVector(2616,168));
    flowerCoords.add(new PVector(2872,168));

    Collections.shuffle(flowerCoords);

    for (PVector flower: flowerCoords) {
        count++;
        if (count > 3) break;

        flowers.add(new Flower(flower));
    }
}

void generateSpawners(){
    //spawners[0] = new PVector(432, 184);
    //spawners[1] = new PVector(592, 184);
    //spawners[2] = new PVector(720, 184);
    //spawners[3] = new PVector(896, 184);
    //spawners[4] = new PVector(1392, 56);
    //spawners[5] = new PVector(1616, 120);
    //spawners[6] = new PVector(2096, 56);
    
    goombas.add(new Goomba(new PVector(432, 184)));
    goombas.add(new Goomba(new PVector(592, 184)));
    goombas.add(new Goomba(new PVector(720, 184)));
    goombas.add(new Goomba(new PVector(896, 184)));
    goombas.add(new Goomba(new PVector(1392, 56)));
    goombas.add(new Goomba(new PVector(1616, 120)));
    goombas.add(new Goomba(new PVector(2096, 56)));
    
}
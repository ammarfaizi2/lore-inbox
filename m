Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131036AbQLJUqB>; Sun, 10 Dec 2000 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131337AbQLJUpw>; Sun, 10 Dec 2000 15:45:52 -0500
Received: from ghost.btnet.cz ([62.80.85.74]:23557 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S131036AbQLJUpm>;
	Sun, 10 Dec 2000 15:45:42 -0500
Message-ID: <20001210211445.00733@ghost.btnet.cz>
Date: Sun, 10 Dec 2000 21:14:45 +0100
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: Dropping chars on 16550
Reply-To: clock@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84
X-Depechemlon: GRU Aquarium Khodinka Vatutinki KGB CIA Putin Suvorov Ladygin FBI NSA IRS whitewater arkanside MOSSAD MI5 ONI CID AK47 M16 C4 wackenhut terrorist task force 160 atomic nuclear Lybia plutonium fission uranium deuterium H-bomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

What should I do, when I run cdda2wav | gogo (riping CD from a ATAPI
CD thru mp3 encoder) and get a continuous dropping of characters, on a 16550-
enhanced serial port, without handshake, with full-duplex load of 115200 bps?
About 1 of 320 bytes is miscommunicated.

The kernel is 2.2.12.

Clock

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

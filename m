Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLJOmv>; Sun, 10 Dec 2000 09:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129231AbQLJOml>; Sun, 10 Dec 2000 09:42:41 -0500
Received: from ulima.unil.ch ([130.223.144.143]:10771 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S129210AbQLJOmb>;
	Sun, 10 Dec 2000 09:42:31 -0500
Date: Sun, 10 Dec 2000 15:11:53 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: EMU10K1 bug (all kernel ->2.4.0-test12pre7)
Message-ID: <20001210151153.A21525@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Well maybe not on all kernel revision, but all I tested the EMU10K1 on there
(most off the time I use ALSA, which as the same bug...).

The bug is that the card as two audio output, they both deliver good sound
for playing wav or mp3, but only one of them deliver the sound that came from
the line in (same for the CD in).

I am sorry if that's not a bug and if there is an easy way to hear the sound
out of the two output (same sound out of the two output, just mirrored).

Thanks you very much,
 
	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270758AbRHSUoB>; Sun, 19 Aug 2001 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270760AbRHSUnw>; Sun, 19 Aug 2001 16:43:52 -0400
Received: from pdbn-3e36abae.pool.mediaWays.net ([62.54.171.174]:12808 "EHLO
	mail.citd.de") by vger.kernel.org with ESMTP id <S270758AbRHSUnf>;
	Sun, 19 Aug 2001 16:43:35 -0400
Date: Sun, 19 Aug 2001 22:43:16 +0200 (MEST)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.(4/9) locks up if floppy & cd-burnning is done at the same time
Message-ID: <Pine.LNX.4.20.0108192234570.29855-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi




I wanted to copy some Floppy-Images back to floppy and i wanted to burn
some CD-Images.

Alone both things work flawlessly. If done at the same time the system
locks up hard. (Tested with 2.4.4 & 2.4.9)

"Short" Summary of system:
Dual PIII-933Mhz, Severworks HE-SL Chipset, 3GB-RAM
Data-HDD, DTLA 307045 (Here were the CD-Images)
5 Channel ICP-Vortex GDTH-6550
  Channel1: 2xPioneer 304 (Here were the Floppy-Images)
  Channel2-5: 1xTeac CD-R58S each

If more information is needed, i will provide them.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.



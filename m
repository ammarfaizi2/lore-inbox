Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130131AbRBBUoK>; Fri, 2 Feb 2001 15:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRBBUoA>; Fri, 2 Feb 2001 15:44:00 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:54700 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130131AbRBBUnq>; Fri, 2 Feb 2001 15:43:46 -0500
Message-Id: <l03130312b6a0c807b32f@[192.168.239.105]>
In-Reply-To: <20010202145149.A129@bug.ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>;
 from Alan Olsen on Mon, Jan 29, 2001 at 02:57:44PM -0800
 <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>
 <Pine.LNX.4.10.10101291452120.31258-100000@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 2 Feb 2001 20:27:37 +0000
To: Pavel Machek <pavel@suse.cz>, Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: Recommended swap for 2.4.x.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:51 pm +0000 2/2/2001, Pavel Machek wrote:
>Hi!
>
>> I am asking because I have just ordered a new drive for my Vaio (8.1 gig
>> in a 8.45mm drive!) and I want to install 2.4.x on it.  (I like getting
>
>8.1GB in under centimeter? That's 8.1GB in compactflash slot?

In general, i think the normal reccommendation is to put around double your
physical RAM size as a swapfile.  In practice, I use 256Mb swap on most
(almost all) my machines, which have physical RAM from 28Mb up to 320Mb.
Only the 28Mb machine ever makes substantial use of that space.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

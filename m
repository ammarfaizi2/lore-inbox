Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSKJWHp>; Sun, 10 Nov 2002 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265199AbSKJWHp>; Sun, 10 Nov 2002 17:07:45 -0500
Received: from zork.zork.net ([66.92.188.166]:14821 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S265198AbSKJWHo>;
	Sun, 10 Nov 2002 17:07:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4: Merge Emulex and Qlogic FC drivers ?
References: <200211102302.39468.daniel.mehrmann@gmx.de>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: DRUGS/ALCOHOL, NON-SEQUITUR
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 10 Nov 2002 22:14:30 +0000
In-Reply-To: <200211102302.39468.daniel.mehrmann@gmx.de> (Daniel Mehrmann's
 message of "Sun, 10 Nov 2002 23:02:39 +0100")
Message-ID: <6ulm419int.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Daniel Mehrmann quotation:

> i want merge the linux driver for FC controllers from Qlogic and 
> Emulex (All series from both) into the kernel tree, because i need 
> this for our company.
>
> Qlogic is clear GPL but Emulex have no GPL. 
> I think the license to use the code is free and i see no problems. 

The last time I looked at an Emulex Linux driver (for the LP-7000,
about six months ago), it consisted of a large binary-only portion,
shipped in a .a file, and the source code for a shim to have the
library code talk to the kernel.

Furthermore, the driver was configured by editing a .c file and
rebuilding it.

All in all, a quality experience.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |

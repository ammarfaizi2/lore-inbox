Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOWsj>; Fri, 15 Dec 2000 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLOWs3>; Fri, 15 Dec 2000 17:48:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27658 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129183AbQLOWsR>; Fri, 15 Dec 2000 17:48:17 -0500
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
To: mikulas@artax.karlin.mff.cuni.cz
Date: Fri, 15 Dec 2000 22:19:25 +0000 (GMT)
Cc: pavel@suse.cz (Pavel Machek), sabre@nondot.org (Chris Lattner),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <Pine.LNX.3.96.1001215205918.13941A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Dec 15, 2000 09:10:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1473CJ-0001w7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess that when you mmap large files over nfs and write to them, you get
> similar problems.
> 
> > Oh, and try to eat atomic memory by ping -f kORBit-ized box.
> 
> When linux is out of atomic memory, it will die anyway.

Not unless your driver is broken.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

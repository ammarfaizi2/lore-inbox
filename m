Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316648AbSEQSq1>; Fri, 17 May 2002 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316647AbSEQSq0>; Fri, 17 May 2002 14:46:26 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:38340 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S316646AbSEQSqZ>; Fri, 17 May 2002 14:46:25 -0400
Date: Fri, 17 May 2002 19:45:44 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Aralion and IDE blasphemy
Message-Id: <20020517194544.6c97490b.jpm@it-he.org>
In-Reply-To: <E178iAB-0006Xu-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 14:52:55 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > The culprit is an ARALION ARS106S chipset card.  Interestingly it works
> > in DOS, and if the hard disks are attached to it, it will even boot
> 
> What does lspci say the chipset really is ?

Here's the entry for it from lspci -v.  I can quote the entire file if you prefer.

00:11.0 RAID bus controller: ARALION Inc: Unknown device 0301
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 10
        I/O ports at ac00 [size=16]
        I/O ports at b000 [size=16]
        I/O ports at b400 [size=16]
        I/O ports at b800 [size=16]
        I/O ports at bc00 [size=16]
        I/O ports at c000 [size=8]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1


However.  I put the thing in to try and relieve a problem of drive bays and
connector lengths.  A bit of lateral thinking has provided another solution
and I no longer need the card urgently.

> 
> Alan
> 


-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  jpm@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)

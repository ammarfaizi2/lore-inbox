Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSERJdS>; Sat, 18 May 2002 05:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSERJdR>; Sat, 18 May 2002 05:33:17 -0400
Received: from warrior.services.quay.plus.net ([212.159.14.227]:24479 "HELO
	warrior.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S311121AbSERJdO>; Sat, 18 May 2002 05:33:14 -0400
Date: Sat, 18 May 2002 10:32:35 +0100
From: "J.P. Morris" <jpm@it-he.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Aralion and IDE blasphemy
Message-Id: <20020518103235.23e5f9a0.jpm@it-he.org>
In-Reply-To: <E178nIx-00077W-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002 20:22:19 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > > What does lspci say the chipset really is ?
> > 
> > Here's the entry for it from lspci -v.  I can quote the entire file if you prefer.
> > 
> > 00:11.0 RAID bus controller: ARALION Inc: Unknown device 0301
> 
> Just the one controller shows up despite it being four ports ?

All the other entries are for hardware I know, so yes.

> > However.  I put the thing in to try and relieve a problem of drive bays and
> > connector lengths.  A bit of lateral thinking has provided another solution
> > and I no longer need the card urgently.
> 
> Aralion claim Linux support so might be worth asking them ?
> http://www.aralion.com/products/raidControl/ideRaid/ideRaid_ultimaRaid100.htm

What they will give you is a Windows program in korean.  Later examination
revealed it to be some kind of self-extracting ZIP file.

Inside are some binary kernel modules they wrote which are specific to RedHat
7.1's version 2.4.2 kernel.

They've just updated their Windows drivers, so they -may- release a more
recent version, but I'd prefer not to have a closed binary module present.


-- 
JP Morris - aka DOUG the Eagle (Dragon) -=UDIC=-  jpm@it-he.org
Fun things to do with the Ultima games            http://www.it-he.org
Developing a U6/U7 clone                          http://ire.it-he.org
d+++ e+ N+ T++ Om U1234!56!7'!S'!8!9!KA u++ uC+++ uF+++ uG---- uLB----
uA--- nC+ nR---- nH+++ nP++ nI nPT nS nT wM- wC- y a(YEAR - 1976)

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317006AbSFALtx>; Sat, 1 Jun 2002 07:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317007AbSFALtw>; Sat, 1 Jun 2002 07:49:52 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:32904 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317006AbSFALtv>; Sat, 1 Jun 2002 07:49:51 -0400
Date: Sat, 1 Jun 2002 05:49:47 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Q] kbuild-2.5: inside or outside Makefile
In-Reply-To: <Pine.LNX.4.44.0206010542510.29405-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0206010548430.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 1 Jun 2002, Thunder from the hill wrote:
> You requested piecemeal of kbuild-2.5, and I'm currently hashing it. Thus 
> one question: someone mentioned to migrate current kbuild-2.4 to 
> kbuild-2.5, while Kaos' version suggests to at first have a separate 
> Makefile-2.5.
> 
> Which do you prefer now? Shall I have it into the current Makefile, or in 
> a separate Makefile-2.5?

Another suggestion: have a Makefile-2.4 and a Makefile-2.5, then symlink 
to which one is getting used.

> <URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/>

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere


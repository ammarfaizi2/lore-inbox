Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSFBMDS>; Sun, 2 Jun 2002 08:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSFBMDS>; Sun, 2 Jun 2002 08:03:18 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:24483 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317170AbSFBMDR>; Sun, 2 Jun 2002 08:03:17 -0400
Date: Sun, 2 Jun 2002 06:03:11 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Peter Osterlund <petero2@telia.com>
cc: Thunder from the hill <thunder@ngforever.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <m2bsathp6q.fsf@ppro.localdomain>
Message-ID: <Pine.LNX.4.44.0206020601320.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2 Jun 2002, Peter Osterlund wrote:
> Yes, I realize this problem will go away automatically when support
> for the old makefile system is removed. I just wanted to present my
> complete list of problems with kbuild 2.5. Except for those three
> issues, I don't see any advantages with the old makefile system.

Well, problem #1 (make TAGS) - what did you use it for?
Problem #2 (make NO_MAKEFILE_GEN) is a bit tricky with the new concept. 
You may try to implement it, but I wonder where you'll end up.
Problem #3 is a migration problem...

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere


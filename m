Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130411AbRBOAqQ>; Wed, 14 Feb 2001 19:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131362AbRBOAqG>; Wed, 14 Feb 2001 19:46:06 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:34374 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S130411AbRBOAps>; Wed, 14 Feb 2001 19:45:48 -0500
Date: Wed, 14 Feb 2001 19:45:47 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: doing RAID 0 with HPT370
In-Reply-To: <Pine.LNX.4.30.0102141618260.6172-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10102141944030.14153-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> do know I get the feeling they don't care to support Linux in any way
> shape or form. Feels like a pawn off job.

afaik, there's no hardware raid support in the chip - it's just 
another dual-channel controller, with some raid0 (perhaps raid1)
software in bios.  I think Andre has said that he has hopes of 
getting docs on HPT's on-disk raid layout - but this is a software
thing, and all it would give us is interoperability with that other OS.


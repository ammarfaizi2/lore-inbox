Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317400AbSFHLUy>; Sat, 8 Jun 2002 07:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317401AbSFHLUx>; Sat, 8 Jun 2002 07:20:53 -0400
Received: from pD9E2320A.dip.t-dialin.net ([217.226.50.10]:64723 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317400AbSFHLUx>; Sat, 8 Jun 2002 07:20:53 -0400
Date: Sat, 8 Jun 2002 05:20:53 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "John L. Males" <jlmales@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something strange going on with the ext2 Filesystem?
In-Reply-To: <20020608031006.1ff5a93a.jlmales@yahoo.com>
Message-ID: <Pine.LNX.4.44.0206080506140.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Jun 2002, John L. Males wrote:
> ***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
> on the LKML, and second I am suffering BIG time with SPAM from posting
> to the mailing list.  Thanks in advance. *****

That's really silly. You won't get killed, I'm not killed either!

> Oh, I was not suggesting it was a e2fsck bug, based on the fact of
> booting the already existing 2.2.19 and making no other changes, e2fsck
> ran just fine.  Suggests a kernel issue in my opinion.

You can even call the current quota system buggy because it doesn't
support the quota utilities we had 5 years ago. But it still is no kernel
bug!

> I need some clarification here.  First can someone explain what is
> ENOSPC?

The errno for "No space left on device."

> Second calrification, I have to assume these ENOSPC bug fixes have been
> effected in the > 2.4.14 kernels.  What I am not sure of is in the
> 2.2.20 Kernel, it is current and are there some outstanding 2.2.20
> ENOSPC bugs?

Alan should have killed them, shouldn't he?

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313138AbSD0L3w>; Sat, 27 Apr 2002 07:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313167AbSD0L3v>; Sat, 27 Apr 2002 07:29:51 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:53966 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S313138AbSD0L3v>;
	Sat, 27 Apr 2002 07:29:51 -0400
Date: Sat, 27 Apr 2002 12:26:46 +0100
Message-Id: <200204271126.g3RBQki24129@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.x-dj and SCSI error handling.
In-Reply-To: <20020427131025.F14743@suse.de>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020427131025.F14743@suse.de> you wrote:
> For instructions on how not to this..
> o   Do not send me patches that just remove the reset: and abort:
>    functions. This gives us no error handling whatsoever.
> o   Do not send me patches re-adding the 'missing' reset & abort functions
>    to the Scsi_Host_Template struct.  This gets us nowhere.

And this also gives you no error handling whatsoever......

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315386AbSEBUD7>; Thu, 2 May 2002 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315387AbSEBUD6>; Thu, 2 May 2002 16:03:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:35316 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315386AbSEBUD5>; Thu, 2 May 2002 16:03:57 -0400
Date: Thu, 2 May 2002 21:59:37 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12: hpt34x.c:259: too few arguments to function `ide_dmaproc'
In-Reply-To: <3CD186E2.9070209@evision-ventures.com>
Message-ID: <Pine.NEB.4.44.0205022159240.21679-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002, Martin Dalecki wrote:

> > Just FYI:
> >
> > The ide_dmaproc changes in 2.5.12 broke the compilation of hpt34x.c (I
> > tried 2.5.12-dj1 but this shouldn't make a difference):
>
>
> The following should do the trick.

Yes, it compiles fine now.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


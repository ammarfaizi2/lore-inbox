Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSD0Ueh>; Sat, 27 Apr 2002 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314547AbSD0Ueg>; Sat, 27 Apr 2002 16:34:36 -0400
Received: from [194.234.65.222] ([194.234.65.222]:61314 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S314512AbSD0Uef>; Sat, 27 Apr 2002 16:34:35 -0400
Date: Sat, 27 Apr 2002 22:34:27 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: Tigran Aivazian <tigran@veritas.com>
cc: Matthew M <matthew.macleod@btinternet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Microcode update driver
In-Reply-To: <Pine.LNX.4.33.0204272114560.1792-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.44.0204272232290.2833-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > where can i find it? Do I need it?
> >
> > microcode_ctl is the userland utility which actually soed the uploading of
> > microcode. You will need to get the appropriate package, and this will come
> 
> if he is running latest Red Hat beta then it is part of kernel-utils
> package:

ok. so what the kernel is telling me during boottime (IA-32 Microcode 
Update Driver: v1.09 <tigran@veritas.com>), is simply having the driver to 
enable such uploads? It'd be great to have this documented openly 
somewhere.

Thanks guys

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.


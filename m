Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315400AbSEGLbm>; Tue, 7 May 2002 07:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSEGLbl>; Tue, 7 May 2002 07:31:41 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:778 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315400AbSEGLbk>; Tue, 7 May 2002 07:31:40 -0400
Date: Tue, 7 May 2002 13:31:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD7A832.2070502@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205071329380.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Martin Dalecki wrote:

> > Please don't do this! There are configurations possible with pci enabled 
> > but without a pci ide adapter.
> 
> So please just don't configure any PCI host chip support there.

Then ide-pci.c is still compiled into the kernel. Why?

bye, Roman


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSEGLsP>; Tue, 7 May 2002 07:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315420AbSEGLsO>; Tue, 7 May 2002 07:48:14 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:27654 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315417AbSEGLsM>; Tue, 7 May 2002 07:48:12 -0400
Date: Tue, 7 May 2002 13:48:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
In-Reply-To: <3CD7ADD1.5080404@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0205071345110.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Martin Dalecki wrote:

> >> Then ide-pci.c is still compiled into the kernel. Why?
> > 
> > Becouse the big tables there are subject to go.
> 
> And at some point in time it will check whatever there is
> request for any host chip support.

Could you please then do the above change _after_ you have done this?

bye, Roman


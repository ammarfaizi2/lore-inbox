Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315256AbSEGXIR>; Tue, 7 May 2002 19:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315271AbSEGXIQ>; Tue, 7 May 2002 19:08:16 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:39698 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S315256AbSEGXIP>; Tue, 7 May 2002 19:08:15 -0400
Date: Wed, 8 May 2002 01:08:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pfn-Functionset out of order for sparc64 in current Bk tree?
In-Reply-To: <20020507192722.GD25874@lug-owl.de>
Message-ID: <Pine.LNX.4.21.0205080059110.32715-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2002, Jan-Benedict Glaw wrote:

> Well, the pfn stuff is 100 rifle shots into feet. It broke so far all
> architectures (not only Sparc64), but also Alpha and all the others.
> It would have been nice if they were worked out and submitted with the
> initial patch...

Providing some lame substitution would have certainly be possible, but
the arch maintainers usually know better how to implement it
efficiently. If there is any problem they know where to ask.

bye, Roman


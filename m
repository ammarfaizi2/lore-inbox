Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSLHMaX>; Sun, 8 Dec 2002 07:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbSLHMaX>; Sun, 8 Dec 2002 07:30:23 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:48008 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265770AbSLHMaW> convert rfc822-to-8bit; Sun, 8 Dec 2002 07:30:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.20-BK
Date: Sun, 8 Dec 2002 13:37:55 +0100
User-Agent: KMail/1.4.3
References: <200212071434.11514.m.c.p@wolk-project.de> <200212072036.08500.m.c.p@wolk-project.de> <asv3d8$nr$1@forge.intermeta.de>
In-Reply-To: <asv3d8$nr$1@forge.intermeta.de>
Organization: WOLK - Working Overloaded Linux Kernel
Cc: hps@intermeta.de
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212081337.56002.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 December 2002 10:29, Henning P. Schmiedehausen wrote:

Hi Henning,

> >    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:pio, hdb:pio
> >    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:pio, hdd:pio
> >    ide2: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
> >    ide3: BM-DMA at 0xffa8-0xffaf, BIOS settings: hda:pio, hdb:DMA
>
> Shouldn't these bei hde - hdh ? I'd be scared by my machine reporting
> hda thrice. :-)
That's why I've writte this also ;) It's an exact output of what I got.

ciao, Marc

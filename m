Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTAISLw>; Thu, 9 Jan 2003 13:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbTAISLw>; Thu, 9 Jan 2003 13:11:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266961AbTAISLv>;
	Thu, 9 Jan 2003 13:11:51 -0500
Date: Thu, 9 Jan 2003 10:16:52 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MB without keyboard controller / USB-only keyboard ?
In-Reply-To: <1042137928.27796.48.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0301091015280.9978-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2003, Alan Cox wrote:

| On Thu, 2003-01-09 at 17:39, Stephan von Krawczynski wrote:
| > > > pc_keyb: controller jammed (0xFF)
| > >
| > > Does your BIOS do keyboard emulation ?
| >
| > It is Compaq EVO D510. It has merely nothing of interest in the BIOS (no
| > keyboard emu). As far as I remember it contains an I845 chipset.
|
| Can you use the USB keyboard to configure the BIOS during boot. If so
| then it almost certainly has USB bios emulation. Another trivial test
| that would be useful is to stick a freedos boot floppy in the box and
| see if freedos works
| -

PS/2 keyboard emulation might not show up in the BIOS Setup menu.
Or do you know that the BIOS doesn't contain PS/2 keyboard emulation?

Have you installed Linux on it?  If so, how did you do that?

Once past this hurdle, there are patches that can help.

-- 
~Randy


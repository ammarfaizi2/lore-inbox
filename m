Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVASPPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVASPPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVASPPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:15:51 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:15040 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261743AbVASPPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:15:45 -0500
In-Reply-To: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
References: <Pine.GSO.4.61.0501191606260.15516@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <F0F87817-6A2C-11D9-AC28-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Paul Mackerras" <paulus@samba.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "H. Peter Anvin" <hpa@zytor.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] raid6: altivec support
Date: Wed, 19 Jan 2005 09:15:23 -0600
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 19, 2005, at 9:08 AM, Geert Uytterhoeven wrote:

> On Wed, 19 Jan 2005, David Woodhouse wrote:
>  > On Wed, 2005-01-19 at 08:45 -0600, Kumar Gala wrote:
>  > > We did talk about looking at using some work Ben did in ppc64 
> with OF
> > > in ppc32.  John Masters was looking into this, but I havent heard 
> much
>  > > from him on it lately.
>  > >
> > > The firmware interface on the ppc32 embedded side is some what 
> broken
> > > in my mind.
> >
> > The binary structure which changes every few weeks and which is 
> shared
>  > between the bootloader and the kernel? Yeah, "somewhat broken" is 
> one
> > way of putting it :)
>  >
> > The ARM kernel does it a lot better with tag,value pairs.
>
> As does m68k... That's why we never got beyond bootinfo major version 
> 2.

Out of interest, on ARM & m68k I would assume that the list of tag's 
gets added to over time?

- kumar


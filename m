Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131816AbRBMOwm>; Tue, 13 Feb 2001 09:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRBMOwc>; Tue, 13 Feb 2001 09:52:32 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9739 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131816AbRBMOwR>; Tue, 13 Feb 2001 09:52:17 -0500
Date: Tue, 13 Feb 2001 09:52:41 -0500 (EST)
From: "Mike A. Harris" <mharris@redhat.com>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Michèl Alexandre Salim 
	<salimma1@yahoo.co.uk>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PCI GART (?)
In-Reply-To: <20010213120932.8110.qmail@web3502.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0102130952160.16755-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Michèl Alexandre Salim wrote:

>This might not be the proper place to ask - my
>apologies - but since it pertains to the Sony
>Picturebook (C1VE - Crusoe) that people have been
>discussing on this list anyway, I hope people don't
>mind too much :)
>
>I have RTFM but on the matter of enabling DRI for the
>ATI Mobility video chipset, which on that notebook is
>a PCI model, there is practically nil information. The
>DRI website mentions using PCI GART, but there is no
>option for that in the kernel. How do I enable this?
>
>Currently running the XFree 4.0.2 from RH 7.0.90 (7.1
>beta, Fisher) on top of my RH 7 + Ximian system and
>when using aviplay it doesn't use any acceleration
>features at all, consequently choppy display. The same
>file plays much better in Windows.
>
>Xdpyinfo shows that Xvideo and Xrender are both
>loaded, so I presume they *should* work.

http://dri.sourceforge.net


--
Mike A. Harris                  Shipping/mailing address:
OS Systems Engineer             190 Pittsburgh Ave., Sault Ste. Marie,
Red Hat Inc.                    Ontario, Canada, P6C 5B3
http://www.redhat.com           Phone: (705)949-2136

"If it isn't source, it isn't software."  -- NASA


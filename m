Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbSL3NdO>; Mon, 30 Dec 2002 08:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSL3NdN>; Mon, 30 Dec 2002 08:33:13 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:26308 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266967AbSL3NdN>;
	Mon, 30 Dec 2002 08:33:13 -0500
Date: Mon, 30 Dec 2002 13:40:09 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Henrik Storner <henrik@hswn.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops, panic: KT400 AGP and IO-APIC problems (Re: Linux v2.5.53)
Message-ID: <20021230134009.GC16072@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Henrik Storner <henrik@hswn.dk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0212232141010.1079-100000@penguin.transmeta.com> <20021224105559.1876.qmail@osiris.hswn.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021224105559.1876.qmail@osiris.hswn.dk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 10:55:59AM -0000, Henrik Storner wrote:
 > I have a Soltek SL75-FRV motherboard with a KT400 chipset.
 > AMD XP processor, 512 MB DDR RAM (Kingston). This is a new
 > system I got a few days ago, and it is giving me headaches:
 > 
 > 1) AGP is not working (kernel oops with 2.5.53)
 > the kernel oops'es when initialising the AGP driver. Copied by hand:

I now have the chipset specs, and a reference board. As soon
as I get a CPU for it in the next week or so, I'll get this
fixed up, until then, just say AGP=n for KT400's.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319440AbSILFTn>; Thu, 12 Sep 2002 01:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319441AbSILFTn>; Thu, 12 Sep 2002 01:19:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2058 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319440AbSILFTm>; Thu, 12 Sep 2002 01:19:42 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PCI: device 00:00.0 has unknown header type 7f, ignoring.
Date: 11 Sep 2002 22:24:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <alp8ec$cb5$1@cesium.transmeta.com>
References: <1031798190.1499.8.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1031798190.1499.8.camel@entropy>
By author:    Nicholas Miell <nmiell@attbi.com>
In newsgroup: linux.dev.kernel
>
> I've been getting this message since, oh, the dawn of time or so.
> I finally worked up enough curiosity to attempt to figure out what the
> mysterious 7f header is, but the PCI specs require money.
> 
> So, anyone out there happen to know what header 7f is, and why the
> kernel doesn't recognize it?
>  

What northbridge (chipset) does your system have?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

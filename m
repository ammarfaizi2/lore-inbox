Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265460AbTGAEQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 00:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTGAEQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 00:16:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265460AbTGAEQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 00:16:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /dev/random broken?
Date: 30 Jun 2003 21:30:30 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bdr2p6$2jp$1@cesium.transmeta.com>
References: <3EFE23A5.2000608@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3EFE23A5.2000608@libero.it>
By author:    "Luca T." <luca-t@libero.it>
In newsgroup: linux.dev.kernel
>
> Hello,
> i am not sure if this is a kernel/module problem but so it seems to me.
> My computer is an AMD 2000+ with an ABIT motherboard, my kernel version
> is 2.4.21-0.13mdk (but i tried it with 2.4.21-0.18mdk too and it doesn't
> work either).
> 

In addition to the other posts in this thread, you may want to load
the hwrng driver and run rngd.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSKOEJO>; Thu, 14 Nov 2002 23:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265752AbSKOEJO>; Thu, 14 Nov 2002 23:09:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64008 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265727AbSKOEJN>; Thu, 14 Nov 2002 23:09:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] early printk for x86
Date: 14 Nov 2002 20:15:50 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ar1sdm$gfe$1@cesium.transmeta.com>
References: <3DD3FCB3.40506@us.ibm.com> <3DD40719.5030108@pobox.com> <3DD428C3.4030700@us.ibm.com> <20021115044300.C20764@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20021115044300.C20764@wotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
> 
> That's overkill. Most architectures have an early_printk equivalent in 
> firmware. Only i386 and x86-64 are not lucky enough to have one 
> that is usable from the CPU mode linux uses.
> 

That's a pretty big assumption.  I wouldn't hold that to be
necessarily true.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTBYBSS>; Mon, 24 Feb 2003 20:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbTBYBSB>; Mon, 24 Feb 2003 20:18:01 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21007 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264984AbTBYBQX>; Mon, 24 Feb 2003 20:16:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BK PATCH] klibc for 2.5.63
Date: 24 Feb 2003 17:26:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3ego8$eac$1@cesium.transmeta.com>
References: <20030224225659.GD3775@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030224225659.GD3775@kroah.com>
By author:    Greg KH <greg@kroah.com>
In newsgroup: linux.dev.kernel
>
> Hi,
> 
> Here's the klibc addition synced up with the latest 2.5.63 kernel tree.
> It's the same patches that I sent last time, so I'm not going to repost
> them here again.
> 

Also, just to make things clear:

Greg has taken on the job of integrating klibc with the kernel, but
please post klibc bug reports to the klibc mailing list at
<klibc@zytor.com>.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

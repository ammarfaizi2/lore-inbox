Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262209AbTCHUwI>; Sat, 8 Mar 2003 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262212AbTCHUwH>; Sat, 8 Mar 2003 15:52:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39430 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262209AbTCHUwG>; Sat, 8 Mar 2003 15:52:06 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Date: 8 Mar 2003 13:02:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4dlp8$gl2$1@cesium.transmeta.com>
References: <20030308.080317.27972826.davem@redhat.com> <Pine.LNX.4.44.0303080826300.2954-100000@home.transmeta.com> <20030308170741.GB29789@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030308170741.GB29789@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
> 
> Actually, I think this libc is very useful and at the risk of depressing hpa
> even more, we may well link BitKeeper against it.  We make no use of anything
> glibc specific since we run on all sorts of platforms and having libc be
> part of the image would be cool if it were small.
> 

You may want to read the klibc CAVEATS file before you start thinking
in that direction...

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRKDDm7>; Sat, 3 Nov 2001 22:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278170AbRKDDmt>; Sat, 3 Nov 2001 22:42:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26123 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278120AbRKDDmc>; Sat, 3 Nov 2001 22:42:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zisofs extension in linus' kernels?
Date: 3 Nov 2001 19:42:23 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9s2dev$a9h$1@cesium.transmeta.com>
In-Reply-To: <20011103215652Z281046-17408+9927@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011103215652Z281046-17408+9927@vger.kernel.org>
By author:    Slo Mo Snail <slomosnail@gmx.net>
In newsgroup: linux.dev.kernel
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> while looking through the kernel source dirs of the 2.4.14-pre7 i found the 
> source files of the isofs compression extension...
> is there any way to enable it?
> defining CONFIG_ZISOFS doesn't work because of thousands of unresolved symbols
> Thanks in advance
> 

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/zisofs-2.4.14-pre8.diff

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

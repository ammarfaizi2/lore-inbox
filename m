Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268351AbTCFUSI>; Thu, 6 Mar 2003 15:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbTCFUSH>; Thu, 6 Mar 2003 15:18:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268351AbTCFUSC>; Thu, 6 Mar 2003 15:18:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Unable to boot a raw kernel image :??
Date: 6 Mar 2003 12:28:05 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b48b0l$5rl$1@cesium.transmeta.com>
References: <20021129132126.GA102@DervishD> <15974.7817.474141.453202@gargle.gargle.HOWL> <3E661F8F.50100@zytor.com> <15975.8192.437452.801287@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <15975.8192.437452.801287@gargle.gargle.HOWL>
By author:    Mikael Pettersson <mikpe@user.it.uu.se>
In newsgroup: linux.dev.kernel
> 
> Indeed. The SYSLINUX 2.02 + mtools combination works like a charm
> for 'make bzdisk'. I'm happy with your nobootsect patch.
> 

Well, Linus keeps dropping it on the floor, so I don't know if we'll
see a working "make bzdisk" in the kernel any time soon :(

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbTCSRZ4>; Wed, 19 Mar 2003 12:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbTCSRZ4>; Wed, 19 Mar 2003 12:25:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9227 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263083AbTCSRZz>; Wed, 19 Mar 2003 12:25:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux on 16-bit processors
Date: 19 Mar 2003 09:36:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5a9r4$ekf$1@cesium.transmeta.com>
References: <17232.1048031207@www59.gmx.net> <1048084009.30751.23.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1048084009.30751.23.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> BTW are "real" 16bit processors actually cheaper any more ? 16bit keeps
> costs down but several 683xx processors seem to use 16bit external
> data bus as do some ARM.
> 

80186 seems to be going strong, still; and EZ80 is available as a
synthesizable core (basically a Z80 with a 24-bit addressing mode and
a very primitime MMU.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

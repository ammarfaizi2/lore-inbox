Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTCFAUW>; Wed, 5 Mar 2003 19:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267104AbTCFAUW>; Wed, 5 Mar 2003 19:20:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9488 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267091AbTCFAUV>; Wed, 5 Mar 2003 19:20:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Unable to boot a raw kernel image :??
Date: 5 Mar 2003 16:30:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b464qq$t0r$1@cesium.transmeta.com>
References: <20021129132126.GA102@DervishD> <20030305161244.GB19439@DervishD> <3E662B2E.6080304@zytor.com> <1046912881.15971.29.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1046912881.15971.29.camel@irongate.swansea.linux.org.uk>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> 
> It seems completely inappropriate to remove a feature from the 'stable'
> kernel tree.
> 

Agreed.  The only issue is whether or not it's too broken to be
considered a feature at this point (my feeling would be that it's not,
and should be removed in 2.5, not 2.4.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

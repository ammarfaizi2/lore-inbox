Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSEVXkK>; Wed, 22 May 2002 19:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSEVXkJ>; Wed, 22 May 2002 19:40:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12047 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313120AbSEVXkI>; Wed, 22 May 2002 19:40:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: It hurts when I shoot myself in the foot
Date: 22 May 2002 16:39:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <acha7p$cge$1@cesium.transmeta.com>
In-Reply-To: <200205221615.g4MGFCH30271@directcommunications.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200205221615.g4MGFCH30271@directcommunications.net>
By author:    Chris <chris@directcommunications.net>
In newsgroup: linux.dev.kernel
> 
> I looked inside the box and found a Pentium II 400, and a Pentium II 450.
> 
> Oddly enough they run together as a 266.
> 

The fact that they have different BogoMIPS figures indicate that that
is not really the case.  It looks more like the second processor is
running at 333 MHz or something.  You definitely have a bizarre box
here, and you probably should be running with the "notsc" option.
Heck, maybe you can reconfigure your mobo and actually run both
processors at 400 MHz.  You'd get quite a performance boost, too...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

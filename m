Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbTCJAj1>; Sun, 9 Mar 2003 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbTCJAj1>; Sun, 9 Mar 2003 19:39:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58631 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262684AbTCJAj0>; Sun, 9 Mar 2003 19:39:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
Date: 9 Mar 2003 16:49:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4gnf1$n6f$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv> <1047209545.4102.3.camel@sonja> <m1adg4kbjn.fsf@frodo.biederman.org> <1047219550.4102.6.camel@sonja>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1047219550.4102.6.camel@sonja>
By author:    Daniel Egger <degger@fhm.edu>
In newsgroup: linux.dev.kernel
> 
> > Etherboot can load to any address < 4GB and can jump to a 32bit entry
> > point.  It's not rocket science or magic just good open source code.
> 
> Maybe etherboot isn't the culprit here, but mknbi won't let me
> create bigger tagged boot kernels.
> 

Try pxelinux... it doesn't need any kind of tagging.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

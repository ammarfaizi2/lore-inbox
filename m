Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTKPE6R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 23:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTKPE6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 23:58:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36876 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261893AbTKPE6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 23:58:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.bkbits.net off the air
Date: 15 Nov 2003 20:57:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bp704k$a61$1@cesium.transmeta.com>
References: <20031114170449.GA32466@work.bitmover.com> <Pine.LNX.4.44.0311140905370.1827-100000@bigblue.dev.mdolabs.com> <20031114171001.GB32466@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031114171001.GB32466@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
> 
> It's not a headache for us to do the conversion, that's fine.  I'd like to
> get rid of the pserver on kernel.bkbits.net because it and the SVN server
> beat up the machine quite a bit.  So an rsync based solution sounds good 
> to me if HPA can handle it.
> 

Machine-resource-wise or bandwidth-wise it's not a problem.  The
coherency mechanism -- in particular, deploying it -- is the only
issue.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

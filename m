Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTDPQbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTDPQbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:31:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2821 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264477AbTDPQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:31:34 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] kdevt-diff
Date: 16 Apr 2003 09:43:04 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7k16o$6r2$1@cesium.transmeta.com>
References: <20030414175141.GS4917@ca-server1.us.oracle.com> <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0304141056450.19302-100000@home.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> (My prefernce for the 32-bit version would be 12+20 bits, but it's not a
> very strong one, and it doesn't really matter for the kernel proper, so I
> think Andries who has been tirelessly working on this for five years or
> more gets the final say on it).
> 

I think 12+20 is a good choice for the 32-bit version (NFSv2 and those
guys.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTLZDrJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 22:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264464AbTLZDrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 22:47:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264463AbTLZDrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 22:47:07 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: GCC 3.4 Heads-up
Date: 25 Dec 2003 19:46:45 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bsgav5$4qh$1@cesium.transmeta.com>
References: <1072403207.17036.37.camel@clubneon.clubneon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1072403207.17036.37.camel@clubneon.clubneon.com>
By author:    Chris Meadors <clubneon@hereintown.net>
In newsgroup: linux.dev.kernel
> 
> Other than the constant barrage of warnings about the use of compound
> expressions as lvalues being deprecated* (mostly because of lines 114,
> 116, and 117 of rcupdate.h, which is included everywhere), the build
> goes very well.
> 
> *It also doesn't like cast or conditional expressions as lvalues.
> 

Okay, that's just insane...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

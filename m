Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTDRSVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTDRSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:21:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263190AbTDRSVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:21:41 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mkinitrd
Date: 18 Apr 2003 11:33:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7pgd9$j1q$1@cesium.transmeta.com>
References: <000501c305cb$a7a8e6b0$0200a8c0@satellite> <20030418172859.GB27055@wind.cocodriloo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030418172859.GB27055@wind.cocodriloo.com>
By author:    Antonio Vargas <wind@cocodriloo.com>
In newsgroup: linux.dev.kernel
> 
> Dave, I recall reading there are problems with building an ext2 initrd
> because of the small size, and it seems that ext3 is fine at the moment.
> Just try to tweak the initrd script to do a ext3 (add -j to the mke2fs).
> 

Why ext2 as opposed to romfs or cramfs?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

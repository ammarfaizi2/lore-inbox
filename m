Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTH3Q1g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTH3Q1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 12:27:36 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261969AbTH3Q1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 12:27:35 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Cloop on Red Hat 9
Date: 30 Aug 2003 09:27:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <biqj9g$nlc$1@cesium.transmeta.com>
References: <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0308211441500.10179-100000@alpha.cpe.ku.ac.th>
By author:    Theewara Vorakosit <g4685034@alpha.cpe.ku.ac.th>
In newsgroup: linux.dev.kernel
>
> Dear All,
> 	I want to create linux distribution on one CD, like Virtual
> Linux. I try to use some compressed file system. I cannot use cramfs
> because supported file size is too small.
> 

You could also use zisofs.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265559AbRGJFey>; Tue, 10 Jul 2001 01:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265562AbRGJFeo>; Tue, 10 Jul 2001 01:34:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39434 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265559AbRGJFec>; Tue, 10 Jul 2001 01:34:32 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: How many pentium-3 processors does SMP support?
Date: 9 Jul 2001 22:34:24 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ie450$d1p$1@cesium.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0107092315140.493-100000@faith.cs.utah.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.GSO.4.21.0107092315140.493-100000@faith.cs.utah.edu>
By author:    Xinwei Xue <xwxue@cs.utah.edu>
In newsgroup: linux.dev.kernel
> 
> Hi, 
> 
> My research group is planning to buy a multi-processor linux machine
> for parallel computing. Does anyone know how many pentium processors the
> linux SMP support? Does it support 8(pentium-three) processors? What
> companies produce such reliable multi-processor (>4) machines? Thanks a
> lot! 
> 

It supports up to 32, if you can find a machine that has that many.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSLQUgo>; Tue, 17 Dec 2002 15:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLQUgo>; Tue, 17 Dec 2002 15:36:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265400AbSLQUgn>; Tue, 17 Dec 2002 15:36:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Date: 17 Dec 2002 12:44:22 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ato2b6$v48$1@cesium.transmeta.com>
References: <FKEAJLBKJCGBDJJIPJLJAEOLDLAA.scott@coyotegulch.com> <20021216232755.GA3750@werewolf.able.es> <200212170614.gBH6ELs15888@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200212170614.gBH6ELs15888@Port.imtp.ilyichevsk.odessa.ua>
By author:    Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In newsgroup: linux.dev.kernel
> 
> As to HT, it's definitely a good thing. Multiple CPUs on a chip is
> a logical step. HT in P4 is rather weak, but future processors will
> likely have more advanced cores.
> 

SMT and SMP-on-chip are two very different things.

> I never heard about HT from AMD camp. I'm curious what they do. ;)

Not have insanely long pipelines, so that a single thread can actually
use the processor functional units?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRKYVhL>; Sun, 25 Nov 2001 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281080AbRKYVhA>; Sun, 25 Nov 2001 16:37:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19981 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281077AbRKYVgq>; Sun, 25 Nov 2001 16:36:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Athlon /proc/cpuinfo anomaly [minor]
Date: 25 Nov 2001 13:36:14 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tro8e$po1$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111221653290.28285-100000@netfinity.realnet.co.sz> <Pine.LNX.4.33.0111221552260.20788-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0111221552260.20788-100000@Appserv.suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Thu, 22 Nov 2001, Zwane Mwaikambo wrote:
> 
> > hmm i've always been under the impression that those strings are hard
> > encoded into the CPU so even if we're on a motherboard/bios which doesn't
> > "support" that particular CPU we can do a cpuid and get the same string.
> 
> It likely has a less descriptive hardware default, but it can be
> (and is advised to be for bios writers) overridden in software.
> 

No, the defaults are in the CPU if the CPU is recent enough.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310439AbSCGSdK>; Thu, 7 Mar 2002 13:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310440AbSCGSdC>; Thu, 7 Mar 2002 13:33:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53775 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310439AbSCGScx>; Thu, 7 Mar 2002 13:32:53 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: a faster way to gettimeofday? rdtsc strangeness
Date: 7 Mar 2002 10:32:36 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a68bo4$b18$1@cesium.transmeta.com>
In-Reply-To: <E16iz57-0002SW-00@the-village.bc.nu> <1015515815.4373.61.camel@pc-16.office.scali.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1015515815.4373.61.camel@pc-16.office.scali.no>
By author:    Terje Eggestad <terje.eggestad@scali.com>
In newsgroup: linux.dev.kernel
> 
> Can /proc/cpuinfo really be trusted in figuring out how long a cycle is?
> 

It uses RDTSC, so yes.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

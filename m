Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311038AbSCHTR7>; Fri, 8 Mar 2002 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311039AbSCHTRk>; Fri, 8 Mar 2002 14:17:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3592 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311027AbSCHTRa>; Fri, 8 Mar 2002 14:17:30 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gettimeofday() system call timing curiosity
Date: 8 Mar 2002 11:16:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6b2n0$ur4$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.3.95.1020308134552.6627A-100000@chaos.analogic.com> <025b01c1c6d4$63c05500$aab270d5@homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <025b01c1c6d4$63c05500$aab270d5@homeip.net>
By author:    johan.adolfsson@axis.com
In newsgroup: linux.dev.kernel
> 
> Another thought: Isn't it quite common that clock generators has a
> mode where the frequency differs around the desired frequency to
> spread the spectrum and easier pass EMC tests?
> 

Indeed it is.  It's usually supposed to average out relatively
quickly, however.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

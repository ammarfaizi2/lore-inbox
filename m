Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267412AbTALTWW>; Sun, 12 Jan 2003 14:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267413AbTALTWW>; Sun, 12 Jan 2003 14:22:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24580 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267412AbTALTWV>; Sun, 12 Jan 2003 14:22:21 -0500
Date: Sun, 12 Jan 2003 11:26:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Robert Love <rml@tech9.net>, <L.A.van.der.Duim@student.rug.nl>,
       <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add explicit Pentium II support
In-Reply-To: <1042402563.16288.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301121125370.14031-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Jan 2003, Alan Cox wrote:
> 
> Looks good. Might also be good to clarify in the help whether the PII/PIII
> option also skips using lock decb for the spinlocks and the other fence
> workarounds for the PPro fence errata. 

The thing I reacted to was that the P4 entry should include the P4-based 
celerons. I have no idea what those are called, though.

Anyway, applied.

		Linus


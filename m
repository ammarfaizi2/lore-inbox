Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbSAEHJu>; Sat, 5 Jan 2002 02:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbSAEHJa>; Sat, 5 Jan 2002 02:09:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15366 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287565AbSAEHJ0>; Sat, 5 Jan 2002 02:09:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 23:09:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a168qt$pbi$1@cesium.transmeta.com>
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.40.0201031150090.2600-100000@marvin.loppu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.40.0201031150090.2600-100000@marvin.loppu.net>
By author:    Henrik Hovi <henrik.hovi@loppu.net>
In newsgroup: linux.dev.kernel
> 
> These days hardware is cheap. BUT most of the people using their computer
> as a typewriter and a means to easily do the important things with the
> bank are NOT ready to upgrade to a new state-of-art Itanium 2GHz byte
> crusher with a nice GeForce 5 accelerator and an integrated coffee cooker
> (okay, they would like that one) even though they were cheaper than a
> pair socks. The world doesn't work that way. They don't need such
> monsters and that's it.
> 

They also, usually, don't need to build customized kernels.  In fact,
I would argue that for *those* people, anything that gets in the way
of dynamic autodetection (plop a new card in your machine, or connect
a new thing to your USB/PCMCIA/FireWire/ADB/SCSI bus, and the machine
should work on the next boot *without* having to go though a
recompilation process) is a major mistake.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267459AbTA1ShD>; Tue, 28 Jan 2003 13:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTA1ShD>; Tue, 28 Jan 2003 13:37:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12047 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267459AbTA1ShC>; Tue, 28 Jan 2003 13:37:02 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Bootscreen
Date: 28 Jan 2003 10:46:04 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b16j5c$4kl$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0301281149070.20509-100000@schubert.rdns.com> <200301281515.15611.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200301281515.15611.roy@karlsbakk.net>
By author:    Roy Sigurd Karlsbakk <roy@karlsbakk.net>
In newsgroup: linux.dev.kernel
> 
> You'll never send an engineer out to replace a set-top-box. You'll just wait 
> for the customer to return the box and send out a new one. Software doesn't 
> fail on those - it's some 99.9% hardware failure. If you get a hang or panic 
> or something, the boxes usually have watchdogs to take care of that (and then 
> reboot automatically). The average computer-frightened user getting an STB 
> from the VoD/IPTV company (or her ISP) don't want to see any kernel 
> gibberish. They just want a nice splash screen telling them "everything's 
> gonna be alright in 45 seconds" or something. Trouble shooting is
> done in the lab after the box is returned
> 

Right, which is why those boxes when running Linux invariably direct
their kernel messages to a debugging port of some sort (usually a
serial port.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

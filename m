Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbSLSXBP>; Thu, 19 Dec 2002 18:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267733AbSLSXBP>; Thu, 19 Dec 2002 18:01:15 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:5338 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267729AbSLSXBK>;
	Thu, 19 Dec 2002 18:01:10 -0500
Date: Thu, 19 Dec 2002 15:08:56 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Message-ID: <20021219230856.GA8392@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Krasnyansky wrote :
> Ok. Drop me a note and I'll push this stuff to BK were you can pull from. 
> In the mean time I'll go bug other folks :). I want to do same kinda changes 
> for the TTY ldisc code.
> 
> Max

	Go for it, I've got the exact same problem with IrDA (both
socket and tty ldisc). Maybe worth sending an entry for the FAQ of
Rusty and include PPP maintainer in the loop.
	Have fun...

	Jean

P.S. : Talking about it, I'm away for Chrismas & New-Year...

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267723AbSLSXPi>; Thu, 19 Dec 2002 18:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbSLSXPi>; Thu, 19 Dec 2002 18:15:38 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:12942 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S267723AbSLSXPh>; Thu, 19 Dec 2002 18:15:37 -0500
Message-Id: <5.1.0.14.2.20021219151718.0477f198@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 19 Dec 2002 15:23:31 -0800
To: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
In-Reply-To: <20021219230856.GA8392@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:08 PM 12/19/2002 -0800, Jean Tourrilhes wrote:
>Max Krasnyansky wrote :
>> Ok. Drop me a note and I'll push this stuff to BK were you can pull from. 
>> In the mean time I'll go bug other folks :). I want to do same kinda changes 
>> for the TTY ldisc code.
>> 
>> Max
>
>        Go for it, I've got the exact same problem with IrDA (both
>socket and tty ldisc). 
Sockets should work with my patch and I'll fix ldisc today or tomorrow.

>Maybe worth sending an entry for the FAQ of Rusty and include PPP maintainer 
>in the loop.
Ok.

>P.S. : Talking about it, I'm away for Chrismas & New-Year...
Happy holidays then.

Max


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292715AbSBUTGK>; Thu, 21 Feb 2002 14:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292716AbSBUTGA>; Thu, 21 Feb 2002 14:06:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24965 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292715AbSBUTFp>; Thu, 21 Feb 2002 14:05:45 -0500
Date: Thu, 21 Feb 2002 14:05:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tom Epperly <tepperly@llnl.gov>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: RH7.2 running 2.4.9-21-SMP (dual Xeon's) yields "Illegal instructions"
In-Reply-To: <Pine.LNX.4.44.0202211010270.19681-100000@tux06.llnl.gov>
Message-ID: <Pine.LNX.3.95.1020221140312.24582B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Tom Epperly wrote:

> On Thu, 21 Feb 2002, Alan Cox wrote:
> 
> > Almost every other report I have ever seen that looked like that one has
> > always turned out to be hardware related. The randomness in paticular
> > tends to be a pointer to thinks like cache faults.
> 

> 5. nVidia Corp NV15 GL (Quadro2) plugged into the AGP slot.
     ^^^^^^^^^^^^^^^^^^^^^_________ Bingo!

Just for kicks, grab some other screen card.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321


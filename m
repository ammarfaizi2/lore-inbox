Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318870AbSH1PcO>; Wed, 28 Aug 2002 11:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318872AbSH1PcO>; Wed, 28 Aug 2002 11:32:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16515 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318870AbSH1PcN>; Wed, 28 Aug 2002 11:32:13 -0400
Date: Wed, 28 Aug 2002 11:37:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: yodaiken@fsmlabs.com, Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <1030548687.7190.33.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1020828113422.15919A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2002, Alan Cox wrote:

> I would expect port 0x378 on any modern PC to be on the X-bus not on ISA

Correct. All that stuff is in the Super-I/O chip now-a-days as I
previously stated. It's also called the GP bus (General Purpose).
It doesn't have slots and their attendent capacity so it's a lot
faster than ISA was.  

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267898AbRGVEWH>; Sun, 22 Jul 2001 00:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267900AbRGVEV5>; Sun, 22 Jul 2001 00:21:57 -0400
Received: from juicer03.bigpond.com ([139.134.6.79]:35786 "EHLO
	mailin6.bigpond.com") by vger.kernel.org with ESMTP
	id <S267899AbRGVEVq>; Sun, 22 Jul 2001 00:21:46 -0400
Message-Id: <m15O8ev-000CDBC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Friedley <saai@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic problem. (smp, iptables?) 
In-Reply-To: Your message of "Mon, 16 Jul 2001 21:35:34 EST."
             <005f01c10e69$28273e60$0200a8c0@loki> 
Date: Sun, 22 Jul 2001 12:07:52 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <005f01c10e69$28273e60$0200a8c0@loki> you write:
> My problem is, that I seem to be having "random" kernel panics.  When I say
> random I mean that the system will run 30 minutes before it panics, or as

Looks like the pppoe problem DaveM found.  Patch in progress...

Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286840AbRL1KzF>; Fri, 28 Dec 2001 05:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286836AbRL1Kyz>; Fri, 28 Dec 2001 05:54:55 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:45784 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286840AbRL1Kym>; Fri, 28 Dec 2001 05:54:42 -0500
Date: Fri, 28 Dec 2001 12:53:13 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Anton Tinchev <atl@top.bg>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <3C2CD97C.A0B9FCF2@top.bg>
Message-ID: <Pine.LNX.4.33.0112281248190.29899-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Anton Tinchev wrote:

> The problem is with the kernel driver - i locks under heavy load (over 2
> 000-3 000 packet/s, may be less).
> Change the card if you can, i didn't recommend you this card for production
> server.

Unfortunately it was the onboard one, plus a rather cool dual eepro100
card. And yes the server does experience quite a load when everyone is in
the office. But not the lockups everyone else seems to be experiencing.

Cheers,
	Zwane Mwaikambo



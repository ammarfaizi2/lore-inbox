Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSH1B2e>; Tue, 27 Aug 2002 21:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSH1B2e>; Tue, 27 Aug 2002 21:28:34 -0400
Received: from 203-79-122-66.cable.paradise.net.nz ([203.79.122.66]:28932 "EHLO
	ruru.local") by vger.kernel.org with ESMTP id <S318501AbSH1B2e>;
	Tue, 27 Aug 2002 21:28:34 -0400
Date: Wed, 28 Aug 2002 13:32:36 +1200
From: Volker Kuhlmann <hidden@paradise.net.nz>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel losing time
Message-ID: <20020828013236.GA13595@paradise.net.nz>
References: <20020825105500.GE11740@paradise.net.nz> <Pine.LNX.4.44.0208250459500.3234-100000@hawkeye.luckynet.adm> <20020825215515.GA2965@debill.org> <1030320314.16766.25.camel@irongate.swansea.linux.org.uk> <20020826011332.GA8440@paradise.net.nz> <1030356936.16651.37.camel@irongate.swansea.linux.org.uk> <20020826122752.A1547@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020826122752.A1547@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody seems to have a solution and I figure that these chipsets (VIA
Technologies, Inc. VT82C585VP + VT82C586/A/B) are buggy. However,
kernel 2.2.19 works fine, 2.4 doesn't at all.
And -d1 -u1 gives 1.1MB/s, -d0 -u1 gives 3.5M/s, which seems funny.

Can someone please say where exactly the problem is, and which part of
the kernel deals with it? The IDE driver? The timer? How would I go
about fixing it again?

These machines are supposed to make good firewalls!

Thanks all,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.orcon.net.nz/		Please do not CC list postings to me.

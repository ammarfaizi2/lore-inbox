Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVLWAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVLWAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLWAA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:00:26 -0500
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:62246 "EHLO
	BAYC1-PASMTP07.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751146AbVLWAAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:00:25 -0500
Message-ID: <BAYC1-PASMTP079D10C7C145C9B3DC52A4AE330@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Message-ID: <50572.10.10.10.28.1135296023.squirrel@linux1>
In-Reply-To: <Pine.LNX.4.58.0512221551030.3425@shark.he.net>
References: <20051222114147.GA18878@elte.hu>   
    <20051222035443.19a4b24e.akpm@osdl.org>   
    <20051222122011.GA20789@elte.hu>   
    <20051222050701.41b308f9.akpm@osdl.org>   
    <1135257829.2940.19.camel@laptopd505.fenrus.org>   
    <20051222054413.c1789c43.akpm@osdl.org>   
    <1135260709.10383.42.camel@localhost.localdomain>   
    <20051222153014.22f07e60.akpm@osdl.org>   
    <20051222233416.GA14182@infradead.org>
    <BAYC1-PASMTP04B55F85E952E6722013B5AE300@CEZ.ICE>
    <Pine.LNX.4.58.0512221551030.3425@shark.he.net>
Date: Thu, 22 Dec 2005 19:00:23 -0500 (EST)
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: "Sean" <seanlkml@sympatico.ca>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: "Christoph Hellwig" <hch@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, nico@cam.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 23 Dec 2005 00:01:08.0828 (UTC) FILETIME=[FA37D1C0:01C60753]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, December 22, 2005 6:53 pm, Randy.Dunlap said:

> Andrew can surely answer that, but it could be something as
> simple as wanting to build a more stable kernel (one without
> so much churn), so that things have time to mature and
> improve without breaking so many other things...
>
> This (current) is a hectic development cycle style.

Sure, its probably that simple.  Just seems like the techincal arguments
clearly support adding a mutex.

Sean


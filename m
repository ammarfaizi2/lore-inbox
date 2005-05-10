Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVEJQsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVEJQsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVEJQsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:48:04 -0400
Received: from mout.perfora.net ([217.160.230.40]:9691 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261703AbVEJQr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:47:57 -0400
Subject: Re: x86-64 bad pmds in 2.6.11.6 II
From: Christopher Warner <chris@servertogo.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, cwarner@kernelcode.com,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050510162620.GP27549@shell0.pdx.osdl.net>
References: <20050415172408.GB8511@wotan.suse.de>
	 <20050415172816.GU493@shell0.pdx.osdl.net>
	 <Pine.LNX.4.61.0504151833020.29919@goblin.wat.veritas.com>
	 <20050419133509.GF7715@wotan.suse.de>
	 <Pine.LNX.4.61.0504191636570.13422@goblin.wat.veritas.com>
	 <1114773179.9543.14.camel@jasmine> <20050429173216.GB1832@redhat.com>
	 <20050502170042.GJ7342@wotan.suse.de> <1115047729.19314.1.camel@jasmine>
	 <1115717814.7679.2.camel@jasmine>
	 <20050510162620.GP27549@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 10 May 2005 08:03:58 -0400
Message-Id: <1115726638.7679.16.camel@jasmine>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats from a couple of days ago. The bug used to be easily reproducible
and then it just stopped suddenly.

I've thrown the loads of the server machines in question way into the
2000 range with lots of threads, io, cpu usage. I'm really confused as
to what exactly it could be. I'm going to try on a couple of different
machines this week.

I'm starting to suspect it has something to do with the mobo itself,
since I have two or three next to me I'll try on those other machines
and then try on a completely different machine/motherboard.

It's really sneaky, so we'll see what happens.
 
On Tue, 2005-05-10 at 09:26 -0700, Chris Wright wrote:
> * Christopher Warner (chris@servertogo.com) wrote:
> > 2.6.11.5 kernel,
> > Tyan S2882/dual AMD 246 opterons
> 
> Got a time stamp by any chance (or a clue re: what was going on at the
> time)?
> 
> thanks,
> -chris


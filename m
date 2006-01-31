Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWAaPF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWAaPF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 10:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWAaPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 10:05:27 -0500
Received: from khc.piap.pl ([195.187.100.11]:9486 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1750877AbWAaPF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 10:05:27 -0500
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, stable@kernel.org, jmforbes@linuxtx.org,
       zwane@arm.linux.org.uk, tytso@mit.edu, davej@redhat.com,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 0/6] 2.6.14.7 -stable review
References: <20060128021749.GA10362@kroah.com>
	<Pine.LNX.4.63.0601282028210.7205@localhost.localdomain>
	<20060128204531.4786aaea.rdunlap@xenotime.net>
	<Pine.LNX.4.63.0601282053170.7205@localhost.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 31 Jan 2006 16:05:22 +0100
In-Reply-To: <Pine.LNX.4.63.0601282053170.7205@localhost.localdomain> (Chuck Wolber's message of "Sat, 28 Jan 2006 21:02:16 -0800 (PST)")
Message-ID: <m3d5i8tp3h.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Wolber <chuckw@quantumlinux.com> writes:

> I don't know if there is a problem, but it goes against the concept of 
> "one-off" fixes that aren't maintained

If they have time for this then great, I can't see any drawbacks.
The early concept was just meant to limit the workload.

> (aka the purpose of the -stable 
> team). This slope eventually leads us to backporting -stable fixes from 
> other -stable releases etc etc.

As long as they can contribute their time it's a win.
-- 
Krzysztof Halasa

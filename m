Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUDLUum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUDLUum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:50:42 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:23750 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263079AbUDLUuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:50:40 -0400
Date: Mon, 12 Apr 2004 16:50:59 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, spyro@f2s.com,
       rmk@arm.linux.org.uk, davidm@hpl.hp.com, paulus@au.ibm.com,
       benh@kernel.crashing.org, jes@trained-monkey.org, ralf@gnu.org,
       matthew@wil.cx, davem@redhat.com, wesolows@foobazco.org,
       jdike@karaya.com, ak@suse.de
Subject: Re: [PATCH][RFC] sort out CLOCK_TICK_RATE usage [0/3]
In-Reply-To: <20040412201156.B5625@Marvin.DL8BCU.ampr.org>
Message-ID: <Pine.LNX.4.58.0404121650220.18930@montezuma.fsmlabs.com>
References: <20040412075519.A5198@Marvin.DL8BCU.ampr.org>
 <Pine.LNX.4.58.0404121246310.18930@montezuma.fsmlabs.com>
 <20040412201156.B5625@Marvin.DL8BCU.ampr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Thorsten Kranzkowski wrote:

> > Isn't this supposed to be PIT_TICK_RATE?
>
>
> I reused the define in arch/alpha/kernel/time.c that served exactly
> the same purpose. I have no problems to call this a timer instead
> of a counter, though. :)

Well i was thinking more Programmable Interrupt Controller.

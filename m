Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVACTNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVACTNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVACTNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:13:00 -0500
Received: from holomorphy.com ([207.189.100.168]:34461 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261617AbVACTL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:11:29 -0500
Date: Mon, 3 Jan 2005 11:07:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103190731.GN29332@holomorphy.com>
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103185927.C3442@flint.arm.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:36:21PM -0500, Theodore Ts'o wrote:
>> This is the model that we used with the
>> 2.3.x series, where the time between releases was often quite short.
>> That worked fairly well, but we stopped doing it when the introduction
>> of BitKeeper eliminated the developer synch-up problem.  But perhaps
>> we've gone too far between 2.6.x releases, and should shorten the time
>> in order to force more testing.  

On Mon, Jan 03, 2005 at 06:59:27PM +0000, Russell King wrote:
> It is also the model we used until OLS this year - there was a 2.6
> release about once a month prior to OLS.  Post OLS, it's now once
> every three months or there abouts, which, IMO is far too long.
> I really liked the way pre-OLS 2.6 was working... it means I don't
> have to twiddle my fingers getting completely bored waiting for the
> next 2.6 release to happen.  Can we return to that methodology please?

Seconded.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVACTdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVACTdH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVACTdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:33:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:23008 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261526AbVACTc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 14:32:57 -0500
Message-ID: <41D99C5F.50803@osdl.org>
Date: Mon, 03 Jan 2005 11:26:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: "Theodore Ts'o" <tytso@mit.edu>, Bill Davidsen <davidsen@tmr.com>,
       Adrian Bunk <bunk@stusta.de>, Diego Calleja <diegocg@teleline.es>,
       Willy Tarreau <willy@w.ods.org>, wli@holomorphy.com, aebr@win.tue.nl,
       solt2@dns.toxicfilms.tv, linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050103134727.GA2980@stusta.de> <Pine.LNX.3.96.1050103115639.27655A-100000@gatekeeper.tmr.com> <20050103183621.GA2885@thunk.org> <20050103185927.C3442@flint.arm.linux.org.uk>
In-Reply-To: <20050103185927.C3442@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jan 03, 2005 at 01:36:21PM -0500, Theodore Ts'o wrote:
> 
>>This is the model that we used with the
>>2.3.x series, where the time between releases was often quite short.
>>That worked fairly well, but we stopped doing it when the introduction
>>of BitKeeper eliminated the developer synch-up problem.  But perhaps
>>we've gone too far between 2.6.x releases, and should shorten the time
>>in order to force more testing.  
> 
> 
> It is also the model we used until OLS this year - there was a 2.6
> release about once a month prior to OLS.  Post OLS, it's now once
> every three months or there abouts, which, IMO is far too long.
> 
> I really liked the way pre-OLS 2.6 was working... it means I don't
> have to twiddle my fingers getting completely bored waiting for the
> next 2.6 release to happen.  Can we return to that methodology please?

Agreed.  We (whoever "we" are) have erred too much on longer
cycles for stability, but it's not working out as hoped IMO.


-- 
~Randy

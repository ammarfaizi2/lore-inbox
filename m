Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWIUGg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWIUGg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 02:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIUGg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 02:36:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:28814 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750703AbWIUGg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 02:36:58 -0400
Message-ID: <45123307.8090809@garzik.org>
Date: Thu, 21 Sep 2006 02:36:55 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org>	<45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org>
In-Reply-To: <20060920220744.0427539d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> If you think that shortening the release cycle will cause people to be more
> disciplined in their changes, to spend less time going berzerk and to spend
> more time working with our users and testers on known bugs then I'm all
> ears.

Honestly, I do think it would be positive.  It would shorten the 
feedback loop, and get more changes out to testers.

It would also decrease the pressure of the 60+ trees trying to get 
everything in, because they know the next release is 3-4 months away. 
It would be _much_ easier to say "break the generic device stuff in 
2.6.20 not 2.6.19, please" if we knew 2.6.20 wasn't going to be a 2007 
release.

	Jeff



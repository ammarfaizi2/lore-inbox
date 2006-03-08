Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWCHLkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWCHLkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWCHLkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:40:51 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:62123 "EHLO enyo.dsw2k3.info")
	by vger.kernel.org with ESMTP id S932496AbWCHLku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:40:50 -0500
Message-ID: <440EC2BA.7010108@citd.de>
Date: Wed, 08 Mar 2006 12:40:42 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Anshuman Gholap <anshu.pg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>	 <20060308102731.GO27946@ftp.linux.org.uk> <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
In-Reply-To: <ec92bc30603080252v7e795b4dm5116d4fe78f92cc7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Gholap wrote:
> well ya, I knew i was running the risk to be labelled like that, cause
> i thought to talk of this issue, more shake is needed that just stir.
> 
> please dont get me wrong (even though i think most of you already
> have), i own my graditude for the livelihood i am having to
> linux,linus and co.

To get to the point of the others binary-only-discussions.

You only see that you can't use a device today.
I know that is annoying, but you have to see the "big picture":

Less hostility regarding binary-only drivers would lead to a "flood" of
binary-only-drivers which are undebuggable and unmaintanable by the kernel
developers. IOW you would be at the mercy of the vendor of the device to
make a compatible driver in the future.

But there is a planet-size catch:
Vendors think in money. So if you have a device that is end of line most
vendors couldn't care less if you can't use it anymore with current systems.
Given that the vendor is still in business after all!

So instead of having a paper-weight today you will have it a few years later.
I don't see the big difference.

IOW. A "new" device may be working today, but will be a paper-weight
later.
Whereas an "old" device will be a paper-weight today, if the vendor only
provided binary-only drivers "back then" when it was "new".

In contrast most times you have an OSS-driver it will work "indefinetly",
as it can be maintained over the years.

It's all a shifting of who is hurt and when. In the long run the current
model should be working better and better. Whereas binary-only drivers
would destroy/undermine the achievements we have now.




-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.


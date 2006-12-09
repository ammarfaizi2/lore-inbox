Return-Path: <linux-kernel-owner+w=401wt.eu-S936971AbWLILeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936971AbWLILeZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 06:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936958AbWLILeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 06:34:24 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59858 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936931AbWLILeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 06:34:23 -0500
Message-ID: <457A9F3B.6020009@garzik.org>
Date: Sat, 09 Dec 2006 06:34:19 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: why are some of my patches being credited to other "authors"?
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   i've submitted a number of patches recently and, every time i do a
> "git pull", i check the log to see if any of them have been applied so
> i can delete them from my personal "submitted but not applied"
> directory.  if they've been applied by another author, then naturally
> i'll never notice and i'll keep wondering about the delay.
> 
>   so what's the protocol here?  are more senior kernel developers
> allowed to poach on my patch submissions, tidy them up slightly, then
> drop any attribution to me?  enquiring minds *definitely* want this
> cleared up.
> 
> rday
> 
> p.s.  it's possible that this is all just a wild coincidence, of
> course.  stranger things have happened.


The protocol is simply to do best to give credit where credit is due. 
If your patch is taken directly, most likely it is a mistake if 
attribution was dropped.  If your patch was modified, often that patch 
will get checked in under the name of the person who last touched the 
change before commit -- and it is their responsibility to make sure and 
note that the change originally came from you.

	Jeff



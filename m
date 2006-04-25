Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWDYSd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWDYSd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWDYSd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:33:56 -0400
Received: from mail.linicks.net ([217.204.244.146]:8617 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S932288AbWDYSdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:33:55 -0400
From: Nick Warne <nick@linicks.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: scheduler question 2.6.16.x
Date: Tue, 25 Apr 2006 19:33:48 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200604251905.19004.nick@linicks.net> <20060425181530.GQ4102@suse.de>
In-Reply-To: <20060425181530.GQ4102@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604251933.48363.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 19:15, Jens Axboe wrote:

> > But I can build both in... so I guess then the kernel decides what is
> > the best to use?  Or should it be so I am only allowed to select one
> > or the other and allowing both is an oversight?
>
> See the option no more than two lines down from that, default io
> scheduler. Also see Documentation/block/switching-sched.txt and/or
> Documentation/kernel-parameters.txt (elevator=) section.

Hi Jens,

I haven't got the switching-sched.txt, although I found a sched-design.txt... 
but what I meant was if I select whatever default, do/can I still need to 
select either/or scheduler?

i.e. why doesn't 'default selection option' only allow that scheduler to be 
selected?

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

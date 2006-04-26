Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWDZSdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWDZSdv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWDZSdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:33:51 -0400
Received: from mail.linicks.net ([217.204.244.146]:6028 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S964776AbWDZSdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:33:50 -0400
From: Nick Warne <nick@linicks.net>
To: Andre Tomt <andre@tomt.net>
Subject: Re: scheduler question 2.6.16.x
Date: Wed, 26 Apr 2006 19:33:43 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
References: <200604251905.19004.nick@linicks.net> <200604251933.48363.nick@linicks.net> <444FB742.40604@tomt.net>
In-Reply-To: <444FB742.40604@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261933.43772.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 April 2006 19:09, Andre Tomt wrote:

> > i.e. why doesn't 'default selection option' only allow that scheduler to
> > be selected?
>
> That would be a artificial (and silly!) limit - the io-scheduler is
> pluggable and selectable at boot, you can even change it at run time at
> a per block device level.
>
> See the elevator= boot option and /sys/block/<device>/queue/scheduler

Ohh!  I see.  That is what I was sort of asking (but didn't know what 
precisely to ask)... OK thanks, understand now.

Nick


-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb

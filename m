Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVCJN5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVCJN5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 08:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbVCJNzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 08:55:43 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22189 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262612AbVCJNzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 08:55:24 -0500
Date: Wed, 9 Mar 2005 20:32:13 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Alexander Nyberg <alexn@dsv.su.se>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: dm-crypt vs. cryptoloop reminder
Message-ID: <20050309193212.GB632@openzaurus.ucw.cz>
References: <1110058524.13821.17.camel@boxen> <20050305224415.GA8837@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305224415.GA8837@pclin040.win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.6.3-mm1 'dm-crypt vs. cryptoloop' discussion was some time ago, it is
> > time to bring this up again:
> > http://kerneltrap.org/node/2433
> 
> Are you a troll?
> 
> This is not something to be quoted by anybody serious.
> 
> Andrew referred to "well-known weaknesses" in cryptoloop,
> and when I inquired it turned out that what he referred to
> were properties of cryptoloop and dm-crypt alike, so that
> his remarks that started that discussion were misguided.
> 
> Of course people may prefer dm-crypt or cryptoloop or loop-aes,
> just like people prefer ide-cd or ide-scsi.
> 
> I have not yet seen a valid reason to deprecate one of these three
> very soon.

I'd say that "no-maintainer" + "maintained code can do the same" is enough, but...
I thought that ide-scsi was deprecated, too?

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWHDAUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWHDAUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWHDAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:20:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41965
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932373AbWHDAUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:20:09 -0400
Date: Thu, 03 Aug 2006 17:20:10 -0700 (PDT)
Message-Id: <20060803.172010.102611616.davem@davemloft.net>
To: tytso@mit.edu
Cc: mchan@broadcom.com, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060804000707.GA15342@thunk.org>
References: <1154647699.3117.26.camel@rh4>
	<20060803.164311.91310742.davem@davemloft.net>
	<20060804000707.GA15342@thunk.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Theodore Tso <tytso@mit.edu>
Date: Thu, 3 Aug 2006 20:07:07 -0400

> Removing the timer-based "ping" might be a good thing to do from the
> point of view of reducing power utilization of laptops (but hey, I
> don't have a tg3 in my laptop, so I won't worry about it a whole lot :-), 

You won't have "ASF" in your laptop tg3. ASF, as the second character
it's acronym implies is for "Servers".

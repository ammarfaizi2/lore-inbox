Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265657AbTA1Og0>; Tue, 28 Jan 2003 09:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTA1Og0>; Tue, 28 Jan 2003 09:36:26 -0500
Received: from home.wiggy.net ([213.84.101.140]:61375 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S265657AbTA1OgZ>;
	Tue, 28 Jan 2003 09:36:25 -0500
Date: Tue, 28 Jan 2003 15:45:45 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-ID: <20030128144544.GB4868@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030128142837.GX4868@wiggy.net> <200301281443.h0SEhSGk001163@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281443.h0SEhSGk001163@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously John Bradford wrote:
> Well, if the machine boots up OK, you can always review the messages
> with dmesg.  If it doesn't, the messages are there to review.

I think we're talking about different things here. Personally I'm more
interested in having this work in environments where you can not look
at dmesg or anything else: appliances that do a single job and have to
do it well. Think ATMs, point of sale machines, settop boxes, etc.
If they break you don't go in and look at dmesg, you replace them.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker

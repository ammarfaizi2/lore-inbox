Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTA1OTT>; Tue, 28 Jan 2003 09:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbTA1OTT>; Tue, 28 Jan 2003 09:19:19 -0500
Received: from home.wiggy.net ([213.84.101.140]:53695 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S265523AbTA1OTS>;
	Tue, 28 Jan 2003 09:19:18 -0500
Date: Tue, 28 Jan 2003 15:28:37 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-ID: <20030128142837.GX4868@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030128133252.GC23296@suse.de> <200301281355.h0SDteN1000666@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281355.h0SDteN1000666@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously John Bradford wrote:
> Surely the most sensible lines to think along are:
> 
> * Make boot times as short as possible

So with a short boot time instead of seeing text messages for a while
you'll get some flickering on the screen - I don't call that an
improvement.

> * Support, and encourage the use of more efficient CPU designs, so
>   that it becomes sensible to leave machines on all the time.

Unfortunately in the real world we are dealing with existing cheap
hardware.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker

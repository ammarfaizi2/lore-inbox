Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVKGM5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVKGM5r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVKGM5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:57:47 -0500
Received: from mgate03.necel.com ([203.180.232.83]:9095 "EHLO
	mgate03.necel.com") by vger.kernel.org with ESMTP id S932483AbVKGM5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:57:46 -0500
To: Ian Campbell <ijc@hellion.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq 0?
References: <buobr0wbrme.fsf@dhapc248.dev.necel.com>
	<1131366352.14696.60.camel@icampbell-debian>
From: Miles Bader <miles.bader@necel.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Mon, 07 Nov 2005 21:57:01 +0900
In-Reply-To: <1131366352.14696.60.camel@icampbell-debian> (Ian Campbell's message of "Mon, 07 Nov 2005 12:25:52 +0000")
Message-Id: <buomzkgaa5e.fsf@dhapc248.dev.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell <ijc@hellion.org.uk> writes:
>> On the v850, irq 0 is a real interrupt, so this doesn't really work
>> properly -- it doesn't display an entry for irq 0.
>
> What makes you say that? The i==0 code seems to fall through and
> therefore should print IRQ0 just fine.

Gee you're right... silly me. :-/

Thanks,

-miles
-- 
Run away!  Run away!

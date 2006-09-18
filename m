Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWIRMf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWIRMf0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWIRMf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:35:26 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:35531 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965152AbWIRMfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:35:25 -0400
Date: Mon, 18 Sep 2006 14:34:25 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Rik van Riel <riel@redhat.com>
cc: yogeshwar sonawane <yogyas@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
In-Reply-To: <450E914C.90203@redhat.com>
Message-ID: <Pine.LNX.4.61.0609181430530.30064@yvahk01.tjqt.qr>
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
 <450DE3DE.50301@redhat.com> <Pine.LNX.4.61.0609181033350.27566@yvahk01.tjqt.qr>
 <450E914C.90203@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Sure, people said that too when going from 16 bits to 32 bits,
>> > but that was only a factor 2^16 difference.  This time it's the
>> > square of the previous difference.
>> 
>> Not quite the square :)
>
> 2^32 is the square of 2^16 :)

Going from 32 to 64:   (2^64 - 2^32)
Going from 16 to 32:   (2^32 - 2^16)

As mentioned above, "the square of the previos" [16 to 32] "difference". 
Call me nitpicky, but:

(2^32 - 2^16)^2  !=  (2^64 - 2^32)

>-- 
> What is important?  What you want to be true, or what is true?


Jan Engelhardt
-- 

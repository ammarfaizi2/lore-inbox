Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268333AbRGWUzf>; Mon, 23 Jul 2001 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268340AbRGWUzZ>; Mon, 23 Jul 2001 16:55:25 -0400
Received: from mail11.svr.pol.co.uk ([195.92.193.23]:18456 "EHLO
	mail11.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267928AbRGWUzW>; Mon, 23 Jul 2001 16:55:22 -0400
From: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.36655.87584.814784@glaramara.freeserve.co.uk>
Date: Mon, 23 Jul 2001 21:55:11 +0100
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: ipt_unclean: TCP flags bad: 4 
In-Reply-To: <m15ObJH-000CD5C@localhost>
In-Reply-To: <15194.61662.338810.87576@glaramara.freeserve.co.uk>
	<m15ObJH-000CD5C@localhost>
X-Mailer: VM 6.93 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 23 Jul 2001 18:43:26 +1000, Rusty Russell <rusty@rustcorp.com.au> said:

> In message <15194.61662.338810.87576@glaramara.freeserve.co.uk> you
> write:
>>  I've just upgraded to 2.4.7, and I'm getting lots of errors:
>> 
>> ipt_unclean: TCP flags bad: 4

> Please try this patch...

That fixes it.

Many thanks.

-- 
Alan J. Wylie                        http://www.glaramara.freeserve.co.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  Antoine de Saint-Exupery

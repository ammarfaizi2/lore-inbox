Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280339AbRKEIQX>; Mon, 5 Nov 2001 03:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280341AbRKEIQN>; Mon, 5 Nov 2001 03:16:13 -0500
Received: from zero.tech9.net ([209.61.188.187]:57102 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280339AbRKEIP4>;
	Mon, 5 Nov 2001 03:15:56 -0500
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0111051019080.6741-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.28.13.59 (Preview Release)
Date: 05 Nov 2001 03:15:46 -0500
Message-Id: <1004948146.806.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-05 at 03:21, Zwane Mwaikambo wrote:
> Thanks, I just saw a thread discussing the very same issue i had, i'll
> download both ac7 and the ac6 preempt patch and give it a try.

Please let me know.. I've had a few reports and I want to consider this
bug fixed -- and not even our fault: the best kind.

I went ahead and rediffed the patch against 2.4.13-ac7, the -ac6 will
apply fine.  For future use however, it will be up at

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/

soon as the it syncs.

> PS I know you keep hearing this, but that preempt patch makes for some
> damn smooth interactive performance ;)

I can't hear it enough :)

	Robert Love


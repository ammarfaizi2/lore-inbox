Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTLBUQS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 15:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbTLBUQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 15:16:17 -0500
Received: from [65.37.126.18] ([65.37.126.18]:28044 "EHLO the-penguin.otak.com")
	by vger.kernel.org with ESMTP id S264360AbTLBUPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 15:15:34 -0500
Date: Tue, 2 Dec 2003 12:16:00 -0800
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel@vger.kernel.org
Subject: Re: XFS for 2.4
Message-ID: <20031202201600.GA26952@the-penguin.otak.com>
References: <20031202002347.GD621@frodo> <Pine.LNX.4.44.0312020919410.13692-100000@logos.cnet> <20031202205502.474755f3.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202205502.474755f3.skraw@ithnet.com>
X-Operating-System: Linux 2.6.0-test10-mm1 on an i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> Even if I am a bit off-topic here, please reconsider your last sentence. Don't
> make people think that 2.6 is in a widely useable state right now. Just take a
> look at the history of 2.4. Don't forget 2.4 can be used in boxes beyond 4 GB
> only right _now_ (2.4.23), all previous versions fall completely apart on i386
> platform. 2.4 is right now nice, useable and pretty stable - and 2.6 has not
> even begun to see the real-and-ugly world yet. There will for sure be a lot of
> interesting test cases during the next months for 2.6, but there are quite an
> amount of people that need a real stable environment - and that's why they will
> have to use 2.4 for at least one year from now on.
> 
Ye gods I'm going to regret butting into this conversation but...

I have moved a couple servers successfully to 2.6.0-pre9, felt (over)
confident that 2.6.x would work on my busiest server. It was a mistake,
lightly loaded it worked great. As user logged in that morning the
server became unstable, processes started waiting forever and hanging,
imap mostly, later exim and openldap. I never reported it for lack of
good debugging info, I plan to take another wack at it in a month or so.


2.4.x is my only option, I would imagine I'm not in the minority here.
I do use XFS, not on this particular server but I do use it and would
like to see it included into 2.4.x for no other reason than 2.6.x is not
stable in all situations.

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 



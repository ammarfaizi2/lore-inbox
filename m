Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271319AbTG2HtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271324AbTG2HtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:49:18 -0400
Received: from routeree.utt.ro ([193.226.8.102]:22464 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S271319AbTG2HtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:49:15 -0400
Message-ID: <4956.194.138.39.55.1059465293.squirrel@webmail.etc.utt.ro>
Date: Tue, 29 Jul 2003 10:54:53 +0300 (EEST)
Subject: Re: [patch] sched-2.6.0-test1-G2
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44.0307251600020.25436-200000@localhost.localdomain>
References: <Pine.LNX.4.44.0307251600020.25436-200000@localhost.localdomain>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar said:
>
>
> i'm seeing good results with this patch on my testbox, but i'm wondering
> whether it fixes the problems you can see on your boxes. (it might as
> well introduce new problems.)
>
> 	Ingo

Ingo,
Sorry for my late answer.
The patch is just great. With this patch I can watch movies with
make -j 10 bzImage in the background.


Thanks for your work.

Bye
Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/



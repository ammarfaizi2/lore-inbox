Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVLCCkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVLCCkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 21:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVLCCkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 21:40:01 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9687 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1750972AbVLCCkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 21:40:00 -0500
Date: Sat, 3 Dec 2005 03:39:46 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, horms@verge.net.au
Subject: Re: security / kbd
Message-ID: <20051203023946.GC24760@apps.cwi.nl>
References: <5f6Fp-1ZB-11@gated-at.bofh.it> <E1EiLA5-0001VE-64@be1.lrz> <20051203013455.GB24760@apps.cwi.nl> <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0512030251570.6039@be1.lrz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 03:11:42AM +0100, Bodo Eggert wrote:
> On Sat, 3 Dec 2005, Andries Brouwer wrote:

> > Didnt I show a "bleeding edge" patch some April 1st or so?
> 
> It's a bad day for presenting a useful patch.

Hardly useful. Somewhat funny. I just looked - it was April 1st, 2002.


> > Let me repeat what I said and you snipped:
> > If there is a security problem, then it should be solved in user space.
> 
> By killing and disabeling all remote logins when root logs in or by 
> ptracing each user program during root sessions? You'd have to do this 
> until we find somebody to do the correct fix in the kernel.

Please describe the perceived security problem.
I see words, but no problem.

You log in remotely to my machine. Want to do something evil.
What precisely do you do?

2.0.34% loadkeys -d
Couldnt get a file descriptor referring to the console

How do you propose this remotely logged-in non-root gets access to
a console file descriptor?

Andries

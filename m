Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUDGRMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDGRMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:12:25 -0400
Received: from web40511.mail.yahoo.com ([66.218.78.128]:37231 "HELO
	web40511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263741AbUDGRMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:12:24 -0400
Message-ID: <20040407171222.99483.qmail@web40511.mail.yahoo.com>
Date: Wed, 7 Apr 2004 10:12:22 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Chris Friesen <cfriesen@nortelnetworks.com>,
       David Weinehall <tao@acc.umu.se>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40740438.6080202@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> David Weinehall wrote:
> 
> > Personally, I think this proposal would be worthy
> for the
> > patch-of-the-month award.
> 
> I dunno...the proposal to rewrite the kernel and
> libc in assembly is 
> pretty high up there....

My proposal gives ability to avoid rewriting of code
and saves time. If there is a time to rewrite code -
it can be rewritten. For parts we don't have time to
rewrite - virtual stack can be used without serious
code modifications.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/

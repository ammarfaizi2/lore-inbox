Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUB0Dnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUB0Dnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:43:41 -0500
Received: from imladris.surriel.com ([66.92.77.98]:29326 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S261207AbUB0Dnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:43:40 -0500
Date: Thu, 26 Feb 2004 22:44:55 -0500 (EST)
From: Rik van Riel <riel@surriel.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <403E2929.2080705@tmr.com>
Message-ID: <Pine.LNX.4.55L.0402262244130.17359@imladris.surriel.com>
References: <1t8wp-qF-11@gated-at.bofh.it> <1th6J-az-13@gated-at.bofh.it>
 <403E2929.2080705@tmr.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Bill Davidsen wrote:

> I disagree.

> It would be nice to have the scheduler identify processes which
> interface to user information devices, but it must be done in a way
> which doesn't open gaping security or misuse holes.

You seem to disagree only with what you think you read,
not with what the code does.  Please read the actual
code, since it seems to do what you propose.


Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

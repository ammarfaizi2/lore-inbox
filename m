Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVDSTYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVDSTYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDSTYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:24:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261630AbVDSTYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:24:34 -0400
Date: Tue, 19 Apr 2005 15:24:00 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Chuck Wolber <chuckw@quantumlinux.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Development Model
In-Reply-To: <1113922249.6277.64.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0504191522140.18066@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
 <1113922249.6277.64.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Arjan van de Ven wrote:

> actually we have shown (and I like the model very much, it's a great way
> to get many features production ready and in the hand of users/customers
> really fast) that it doesn't take an odd number release branch to get
> major changes in. Instead it takes careful design and sufficient testing
> and review and most of the changes can go in anyway.

Perhaps even more importantly, things get merged one change
at a time, and stabilised one change at a time.  This is a
big change from the even/odd numbered kernel series, where
sometimes a bug crops up without anybody knowing exactly
what change introduced it.

The current development model seems to go much smoother than
anything I've seen before.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

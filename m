Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTFRQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbTFRQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:24:59 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:58123 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264994AbTFRQY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:24:58 -0400
Date: Wed, 18 Jun 2003 17:38:50 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
cc: Gerhard Mack <gmack@innerfire.net>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.71 - random console corruption
In-Reply-To: <200306181256.30735@gjs>
Message-ID: <Pine.LNX.4.44.0306181736390.24449-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Interestingly enough it's not console switching that does it.. it's
> > scrolling also as I mentioned before it's not just with preempt enabled.
> >
> > I wonder if theres another problem somewhere?
> I've got simmilar problem with 2.5.72, sometimes keyboard stops to respond (in 
> X windows). Mouse is usefull, all i have to do is restart Xwindows and 
> everything is running well.

So scrolling is the issue. Which console drivers are you using? 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270628AbTGaXdt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274938AbTGaXdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:33:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31215 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S270628AbTGaXdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:33:37 -0400
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Joe Korty <joe.korty@ccur.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030731161703.210470ea.akpm@osdl.org>
References: <20030731224604.GA24887@tsunami.ccur.com>
	 <20030731154740.4e21a6e2.akpm@osdl.org>
	 <20030731231154.GB7852@rudolph.ccur.com>
	 <20030731161703.210470ea.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1059694878.786.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 16:41:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 16:17, Andrew Morton wrote:

> Like this?

You are so damn cunning, Andrew.

Even better, since Joe complained of the "ever changing" list, why not
check for "\[*/[0-9*]\]" ?

	Robert Love




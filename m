Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274942AbTGaXVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274932AbTGaXVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:21:05 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48890 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S274942AbTGaXUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:20:15 -0400
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030731231627.GC7852@rudolph.ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com>
	 <1059692548.931.329.camel@localhost>
	 <20030731230635.GA7852@rudolph.ccur.com> <1059693499.786.1.camel@localhost>
	 <20030731231627.GC7852@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1059694079.786.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 16:27:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 16:16, Joe Korty wrote:

> Actually it is only 20 lines of changes .. 16 lines added, 4 deleted.

I know. But 16 new lines, including a new process flag, seems overkill.
That is all I am saying. Just my opinion.

There are a _lot_ of things root can do wrong.

	Robert Love



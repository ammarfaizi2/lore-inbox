Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274931AbTGaXSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274919AbTGaXR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:17:58 -0400
Received: from users.ccur.com ([208.248.32.211]:16050 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S274915AbTGaXQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:16:44 -0400
Date: Thu, 31 Jul 2003 19:16:27 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731231627.GC7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com> <1059692548.931.329.camel@localhost> <20030731230635.GA7852@rudolph.ccur.com> <1059693499.786.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059693499.786.1.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yah, I know. But this is a lot of code just to prevent root from hanging
> herself, and she has plenty of other ways with which to do that.

Actually it is only 20 lines of changes .. 16 lines added, 4 deleted.
Joe

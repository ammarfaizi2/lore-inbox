Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbTB1VMp>; Fri, 28 Feb 2003 16:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbTB1VMp>; Fri, 28 Feb 2003 16:12:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:39183
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263204AbTB1VMo>; Fri, 28 Feb 2003 16:12:44 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
In-Reply-To: <20030228131206.22fc077c.akpm@digeo.com>
References: <Pine.LNX.4.44.0302281040190.8167-100000@localhost.localdomain>
	 <20030228131206.22fc077c.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1046467381.1346.261.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 28 Feb 2003 16:23:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 16:12, Andrew Morton wrote:

> - The longstanding problem wherein a kernel build makes my X desktop
>   unusable is 90% fixed - it is still possible to trigger stalls, but
>   they are less severe, and you actually have to work at it a bit to
>   make them happen.

That is odd, because I do not see any changes in here that would improve
interactivity.  This looks to be pretty much purely the HT stuff.

Andrew, if you drop this patch, your X desktop usability drops?

Ingo, is there something in here that I am missing?

	Robert Love


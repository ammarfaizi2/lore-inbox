Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUKCA16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUKCA16 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKCAXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 19:23:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:39862 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262377AbUKBW5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:57:13 -0500
Date: Tue, 2 Nov 2004 15:01:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Serial updates
Message-Id: <20041102150112.2ce4831f.akpm@osdl.org>
In-Reply-To: <20041102224329.B10969@flint.arm.linux.org.uk>
References: <20041031175114.B17342@flint.arm.linux.org.uk>
	<1099368552.29693.434.camel@gaston>
	<1099369226.29689.441.camel@gaston>
	<20041102224329.B10969@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Tue, Nov 02, 2004 at 03:20:26PM +1100, Benjamin Herrenschmidt wrote:
> > And here's another one that also fixes a little bug in the
> > default console selection code ...
> 
> Thanks for testing Ben, applied.
> 
> akpm - do you want this set of serial changes to appear in one -mm
> release before hitting Linus?
> 

Not really - there's plenty of time to shake out any problems.

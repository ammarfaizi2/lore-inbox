Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWBQWO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWBQWO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWBQWO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:14:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751813AbWBQWO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:14:58 -0500
Date: Fri, 17 Feb 2006 14:13:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ernst Herzberg <earny@net4u.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc3 macromedia flash regression...
Message-Id: <20060217141337.5590fa20.akpm@osdl.org>
In-Reply-To: <200602172307.06388.earny@net4u.de>
References: <200602170508.52712.list-lkml@net4u.de>
	<200602172038.10408.earny@net4u.de>
	<20060217131618.0a463a8b.akpm@osdl.org>
	<200602172307.06388.earny@net4u.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ernst Herzberg <earny@net4u.de> wrote:
>
> On Friday 17 February 2006 22:16, Andrew Morton wrote:
> > Ernst Herzberg <earny@net4u.de> wrote:
> > > The patch does _not_ fix the problem.
> >
> > Surprised.  Could I ask that you double-check that the patch was applied
> > and that the right kernel was running?
> 
> **doublechecked**, and..... you are right!
> 
> This patch __fixes__ the problem.
> 

Whew.  I thought I was going mad ;)

Thanks for finding the bug.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVL3XuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVL3XuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVL3XuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:50:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22167 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964934AbVL3XuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:50:15 -0500
Date: Fri, 30 Dec 2005 15:49:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       jmerkey@wolfmountaingroup.com
Subject: Re: userspace breakage
Message-Id: <20051230154954.47be93a3.akpm@osdl.org>
In-Reply-To: <1135974176.6039.71.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>
	<1135798495.2935.29.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
	<20051228212313.GA4388@elte.hu>
	<20051228214845.GA7859@elte.hu>
	<20051228201150.b6cfca14.akpm@osdl.org>
	<20051229073259.GA20177@elte.hu>
	<Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	<20051229202852.GE12056@redhat.com>
	<Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	<20051229224103.GF12056@redhat.com>
	<43B453CA.9090005@wolfmountaingroup.com>
	<Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>
	<43B46078.1080805@wolfmountaingroup.com>
	<Pine.LNX.4.64.0512291603500.3298@g5.osdl.org>
	<1135974176.6039.71.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 2005-12-29 at 16:10 -0800, Linus Torvalds wrote:
> 
> > Stuff outside the kernel is almost always either (a) experimental stuff 
> > that just isn't ready to be merged or (b) tries to avoid the GPL.
> 
> (c) So damn specialized that it's not worth even trying to merge.

Or drivers for highly specialised/customised hardware.

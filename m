Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTDQTqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbTDQTqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:46:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:55491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbTDQTqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:46:17 -0400
Date: Thu, 17 Apr 2003 12:58:11 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Recent changes broke mkinitrd?
Message-Id: <20030417125811.42e5a769.shemminger@osdl.org>
In-Reply-To: <20030417114016.6b7074f1.akpm@digeo.com>
References: <20030417111303.706d7246.shemminger@osdl.org>
	<20030417114016.6b7074f1.akpm@digeo.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 11:40:16 -0700
Andrew Morton <akpm@digeo.com> wrote:

> Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > Recent (post 2.5.67) versions of the kernel break the creation
> > of the initial ram disk.
> 
> hmm, so it did.  It'll be the ext2 changes.  mkinitrd works OK if you use
> ext3:

That works for me - Thanks

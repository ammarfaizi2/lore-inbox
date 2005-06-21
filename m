Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVFUPlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVFUPlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFUPkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:40:43 -0400
Received: from peabody.ximian.com ([130.57.169.10]:17831 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262128AbVFUPj0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:39:26 -0400
Subject: Re: -mm -> 2.6.13 merge status
From: Robert Love <rml@novell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42B831B4.9020603@pobox.com>
References: <20050620235458.5b437274.akpm@osdl.org>
	 <42B831B4.9020603@pobox.com>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 11:39:24 -0400
Message-Id: <1119368364.3949.236.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 11:26 -0400, Jeff Garzik wrote:

> > inotify
> > 
> >     There are still concerns about the userspace API and internal
> >     implementation details.  More slogging needed.
> 
> We should ask hpa what he needs for kernel.org.  Ideally kernel.org 
> probably wants <something> that facilitates listening to <something> for 
> a list of files being changed.  That would greatly speed up the robots, 
> and possibly rsync-like activities too.

I've talked to some people who've hooked inotify into rsync
successfully.  Cool hack.

	Robert Love



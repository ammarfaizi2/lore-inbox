Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWHTWu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWHTWu4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWHTWu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:50:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35565 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751762AbWHTWuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:50:55 -0400
Subject: Re: [PATCH] loop.c: kernel_thread() retval check
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Solar Designer <solar@openwall.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060820223442.GA21960@openwall.com>
References: <20060819234629.GA16814@openwall.com>
	 <1156097717.4051.26.camel@localhost.localdomain>
	 <20060820223442.GA21960@openwall.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 00:11:08 +0100
Message-Id: <1156115468.4051.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-21 am 02:34 +0400, ysgrifennodd Solar Designer:
> Alan,
> 
> On Sun, Aug 20, 2006 at 07:15:17PM +0100, Alan Cox wrote:
> > Acked-by: Alan Cox <alan@redhat.com>
> 
> Thanks.
> 
> > but should go into 2.6-mm and be tested in 2.6-mm before 2.4 backport.
> 
> Unfortunately, I do not intend to prepare/test/submit a revision of the
> patch for 2.6-mm, and I might only work on a 2.6 patch in a few months
> from now.  Unless someone else takes care of this, the fix is likely to
> get dropped on the floor.
> 
> Do you really think that getting this fix into 2.4 should be delayed
> like that? 

I have no problem with it going into 2.4. Someone should forward port it
- but there should be plenty of people on the lists to do that.


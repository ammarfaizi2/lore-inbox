Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTLVBUM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbTLVBTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:19:25 -0500
Received: from dp.samba.org ([66.70.73.150]:59116 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264277AbTLVBTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:19:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module Alias back compat code 
In-reply-to: Your message of "Sat, 20 Dec 2003 01:16:45 +0900."
             <87hdzwye8i.fsf@devron.myhome.or.jp> 
Date: Mon, 22 Dec 2003 10:59:48 +1100
Message-Id: <20031222011920.16FB92C097@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <87hdzwye8i.fsf@devron.myhome.or.jp> you write:
> Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> Umm.. Although I may be mis-understanding this problem, is the following
> scripts the not enough?
> 
> This does
> 
> 	block-major-1 -> block-major-1-*

I've applied this, too, thanks.

But I still think we'll want the fallback for people who don't realize
the change or used older generate-modprobe.conf versions.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

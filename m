Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWALVwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWALVwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161327AbWALVwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:52:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161326AbWALVwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:52:40 -0500
Date: Thu, 12 Jan 2006 13:52:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@gmail.com>
cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [git tree] drm tree for 2.6.16-rc1
In-Reply-To: <21d7e9970601121233t1e6c2d99pf6ca3a4569d5a6d7@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0601121352110.3535@g5.osdl.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet> 
 <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
 <21d7e9970601121233t1e6c2d99pf6ca3a4569d5a6d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jan 2006, Dave Airlie wrote:
> 
> Actually none of this tree was causing problems in -mm it was the
> agpgart tree, this tree is fully tested on all my available hardware,
> it is also the first tree that supports multiple cards properly
> without oopsing on module remove....

Ok, since Andrew backs you up on that one, I'll merge asap.

		Linus

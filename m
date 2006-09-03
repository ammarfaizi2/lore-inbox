Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752091AbWICGbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbWICGbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 02:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbWICGbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 02:31:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752091AbWICGa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 02:30:59 -0400
Date: Sat, 2 Sep 2006 23:30:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
 sharing [try #13]
Message-Id: <20060902233023.ce544a00.akpm@osdl.org>
In-Reply-To: <1157264490.3520.16.camel@raven.themaw.net>
References: <20060831102127.8fb9a24b.akpm@osdl.org>
	<20060830135503.98f57ff3.akpm@osdl.org>
	<20060830125239.6504d71a.akpm@osdl.org>
	<20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	<27414.1156970238@warthog.cambridge.redhat.com>
	<9849.1157018310@warthog.cambridge.redhat.com>
	<9534.1157116114@warthog.cambridge.redhat.com>
	<20060901093451.87aa486d.akpm@osdl.org>
	<1157130044.5632.87.camel@localhost>
	<20060901195009.187af603.akpm@osdl.org>
	<1157170272.3307.5.camel@raven.themaw.net>
	<20060901225853.0171fd29.akpm@osdl.org>
	<1157264490.3520.16.camel@raven.themaw.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Sep 2006 14:21:30 +0800
Ian Kent <raven@themaw.net> wrote:

> I guess you haven't got the autofs module loaded instead of autofs4 by
> mistake.

Nope.

> So I wonder what the different is between the setups?

Beats me.  Maybe cook up a debug patch?



-- 
VGER BF report: H 0

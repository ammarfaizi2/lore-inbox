Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbTEBAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 20:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbTEBAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 20:44:27 -0400
Received: from beauty.rexursive.com ([202.59.98.58]:39429 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S262840AbTEBAo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 20:44:26 -0400
Message-ID: <1051837153.3eb1c2e157e90@imp.rexursive.com>
Date: Fri,  2 May 2003 10:59:13 +1000
From: Bojan Smojver <bojan@rexursive.com>
To: trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68: NFS3+exported /mnt/cdrom+eject: system lockup
References: <1051754203.3eb07edb09c51@imp.rexursive.com> <shsd6j3gdan.fsf@charged.uio.no> <1051829732.1529.2.camel@coyote.rexursive.com> <16049.47030.861152.708686@charged.uio.no>
In-Reply-To: <16049.47030.861152.708686@charged.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Trond Myklebust <trond.myklebust@fys.uio.no>:

> >>>>> " " == Bojan Smojver <bojan@rexursive.com> writes:
> 
>      > Anyway, I have observed other strange stuff too, like not being
>      > able to unmount /mnt/cdrom while it's being
>      > exported.
> 
> That is *correct* behaviour. If the partition is exported, then it is
> in use.

Yeah, realised that on my way to work. Sorry, I must be on drugs :-(

So, the only real problem is that crash.

-- 
Bojan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291126AbSAaQJE>; Thu, 31 Jan 2002 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291124AbSAaQIr>; Thu, 31 Jan 2002 11:08:47 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:1979 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291128AbSAaQIa>; Thu, 31 Jan 2002 11:08:30 -0500
Date: Thu, 31 Jan 2002 17:08:12 +0100
From: Andi Kleen <ak@muc.de>
To: Oleg Drokin <green@namesys.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Slab cache name fixes / reiserfs boot bug fix.
Message-ID: <20020131170811.A1367@averell>
In-Reply-To: <20020131002937.A1372@averell> <20020131100219.A11046@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131100219.A11046@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 08:02:19AM +0100, Oleg Drokin wrote:
> Hello!
> 
> On Thu, Jan 31, 2002 at 12:29:37AM +0100, Andi Kleen wrote:
> > slab names. This fixes the reiserfs boot time BUG() that is still in 2.5.3.
> Sorry, What BUG()? The one I know that was related to "reiserfs_inode_cache"

It seems to be gone already, yes. Sorry for the confusion.
Anyways, the slab name patch should be the right thing to fix the interface.

-Andi

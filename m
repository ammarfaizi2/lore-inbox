Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbRAENEr>; Fri, 5 Jan 2001 08:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAENEh>; Fri, 5 Jan 2001 08:04:37 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:8714 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129523AbRAENE0>; Fri, 5 Jan 2001 08:04:26 -0500
Date: Fri, 5 Jan 2001 14:04:08 +0100
From: Claas Langbehn <claas@bigfoot.com>
To: Chris Mason <mason@suse.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: reiserfs patch for 2.4.0-final
Message-ID: <20010105140408.A2812@villariba.2y.net>
In-Reply-To: <244070000.978645169@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <244070000.978645169@tiny>; from mason@suse.com on Thu, Jan 04, 2001 at 04:52:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 04:52:49PM -0500, Chris Mason wrote:
> This patch is meant to be applied on top of the reiserfs
> 3.6.23 patch to get everything working in the new prerelease
> kernels.  The order is:
> 
> untar linux-2.4.0-prerelease.tar.bz2
> apply linux-2.4.0-test12-reiserfs-3.6.23.gz
> apply this patch
> apply the fs/super.c patch to make sure fsync_dev is called
> when unmounting /.  This was already sent to l-k, I'll send
> to the reiserfs list as well.

Is this still correct for the final 2.4.0-kernel ?

Could someone create one single patch for the 2.4.0 ?

Bye,
Claas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

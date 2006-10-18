Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422975AbWJRV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422975AbWJRV0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422988AbWJRV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:26:18 -0400
Received: from pat.uio.no ([129.240.10.4]:52639 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1422975AbWJRV0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:26:17 -0400
Subject: Re: [PATCHSET] nfs endianness annotations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
In-Reply-To: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
References: <E1GX7zV-00047C-PO@ZenIV.linux.org.uk>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 17:26:03 -0400
Message-Id: <1161206763.6095.172.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.9, required 12,
	autolearn=disabled, AWL 1.10, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 04:09 +0100, Al Viro wrote:
> Series below does endianness annotations of nfs and nfsd; it had been
> sitting in my tree for quite a while.  In part it's based on Alexey's
> patches.
> 
> I thought to hold it back until the next merge window, but since we
> do get new breakage that would be instantly caught by endianness checks...
> IMO it makes sense to see if that puppy could be merged at this point.
> In any case, the first patch in series is absolutely needed - it's
> fixing a genuine recently introduced bug.

Hi Al,

ACK on patches # 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12. I'd be quite happy
to get those into mainline ASAP.

I'll defer to Neil for the rest.

Cheers,
  Trond

PS: sorry if you received this message several times. I had problems
resolving an email address in the original reply.


Return-Path: <linux-kernel-owner+w=401wt.eu-S1030350AbWLTVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030350AbWLTVpm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWLTVpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:45:42 -0500
Received: from kenobi.snowman.net ([70.84.9.186]:32946 "EHLO
	kenobi.snowman.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030350AbWLTVpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:45:41 -0500
X-Greylist: delayed 1572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 16:45:41 EST
Date: Wed, 20 Dec 2006 16:19:27 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata fixes
Message-ID: <20061220211927.GI24675@kenobi.snowman.net>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20061220210042.GA25303@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20061220210042.GA25303@havoc.gtf.org>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-2-vserver-686 (i686)
X-Uptime: 16:03:20 up 93 days, 21:12, 19 users,  load average: 0.25, 0.30, 0.27
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jeff@garzik.org) wrote:
> FWIW the Tejun cleanups are a fix, split into three reviewable pieces.
> 
> Also, my local iomap branch has advanced sufficiently enough that I
> think it's high time to kill those libata warnings that spew on every
> build.  (I hear the crowds roar)

Perhaps I missed it, but, when is PMP support going to be included in
main-stream?  Seems like it's been around for a while now and I doubt
I'm the only one extremely frustrated with having to hunt down an
external patch to get a new toy supported.  I'll probably bug the Debian
kernel folks next but it'd be nicer if it was in upstream.

	Thanks!

		Stephen

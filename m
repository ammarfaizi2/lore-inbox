Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUJFNtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUJFNtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269173AbUJFNtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:49:20 -0400
Received: from unthought.net ([212.97.129.88]:54442 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S267232AbUJFNs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:48:58 -0400
Date: Wed, 6 Oct 2004 15:48:55 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: NFS+SMP+XFS problems, Take II
Message-ID: <20041006134855.GV18307@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20041006125931.GU18307@unthought.net> <20041006142610.A30867@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041006142610.A30867@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 02:26:10PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 06, 2004 at 02:59:31PM +0200, Jakob Oestergaard wrote:
> > 
> > Dear all,
> > 
> > The dcache patch (originally from Neil Brown, adapted for 2.6.8.1 by me)
> > has been included in the current 2.6.9 RC. It *seemed* that this patch
> > solved the XFS+NFS+SMP problem completely, and that it would then be
> > possible to finally run an NFS server with XFS on an SMP machine.
> > 
> > Well, close, but not close enough.
> 
> As I told in the thread it's not enough.  I checked in two more XFS fixes,
> they're all in 2.6.9-rc3.

Thanks!

I'll patch the kernel this evening, and we'll see if it can stay up
then.

I'll report back to the lists by the end of the week if the box doesn't
hose itself sooner.

-- 

 / jakob


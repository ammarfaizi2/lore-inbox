Return-Path: <linux-kernel-owner+w=401wt.eu-S932175AbXADRtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbXADRtX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbXADRtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:49:23 -0500
Received: from brick.kernel.dk ([62.242.22.158]:20016 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122AbXADRtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:49:22 -0500
Date: Thu, 4 Jan 2007 18:49:38 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, linux-aio@kvack.org, drepper@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       jakub@redhat.com, mingo@elte.hu
Subject: Re: [PATCHSET 1][PATCH 0/6] Filesystem AIO read/write
Message-ID: <20070104174938.GI11203@kernel.dk>
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20070103141556.82db0e81.akpm@osdl.org> <20070104045621.GA8353@in.ibm.com> <20070104090242.44dd8165.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104090242.44dd8165.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04 2007, Andrew Morton wrote:
> > Please let know how you want this fixed up.
> >
> > >From what I can tell the comments in the unplug patches seem to say that
> > it needs more work and testing, so perhaps a separate fixup patch may be
> > a better idea rather than make the fsaio patchset dependent on this.
> 
> Patches against next -mm would be appreciated, please.  Sorry about that.
> 
> I _assume_ Jens is targetting 2.6.21?

Only if everything works perfectly, 2.6.22 is also a viable target.

-- 
Jens Axboe


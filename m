Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280647AbRK1VDe>; Wed, 28 Nov 2001 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRK1VDY>; Wed, 28 Nov 2001 16:03:24 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:24521 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280647AbRK1VDH>; Wed, 28 Nov 2001 16:03:07 -0500
Date: Wed, 28 Nov 2001 16:03:06 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: Fix knfsd readahead cache in 2.4.15
Message-ID: <20011128160306.F23086@redhat.com>
In-Reply-To: <15362.18626.303009.379772@charged.uio.no> <15362.53694.192797.275363@esther.cse.unsw.edu.au> <20011126.155347.45872112.davem@redhat.com> <20011126202509.J15582@redhat.com> <15363.39718.446155.619699@charged.uio.no> <20011127102348.A19330@redhat.com> <15363.46302.205479.958516@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15363.46302.205479.958516@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Nov 27, 2001 at 04:44:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 04:44:30PM +0100, Trond Myklebust wrote:
> Ah, OK. Sorry for being so dense ;-)
> 
> Yeah, that would be an improvement for knfsd too. The current scheme
> can only manage readahead for 1 reader per inode.
> Are there any records of a more detailed discussion of how to go about
> implementing such a readahead strategy for Linux?

Not yet.  I'm hoping to write such a patch in the next couple of months 
for 2.5.

		-ben
-- 
Fish.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSHGUQ5>; Wed, 7 Aug 2002 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSHGUQ5>; Wed, 7 Aug 2002 16:16:57 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19961 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S315419AbSHGUQ4>; Wed, 7 Aug 2002 16:16:56 -0400
Date: Wed, 7 Aug 2002 16:20:36 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: O_SYNC option doesn't work (2.4.18-3)
Message-ID: <20020807162036.G23670@redhat.com>
References: <EE83E551E08D1D43AD52D50B9F511092E114DE@ntserver2> <shs65ymd4co.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <shs65ymd4co.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Aug 07, 2002 at 06:24:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 06:24:23PM +0200, Trond Myklebust wrote:
> >>>>> " " == Gregory Giguashvili <Gregoryg@ParadigmGeo.com> writes:
> 
>      > Hi, I wonder if someone knows why files open with O_SYNC option
>      > on an NFS mounted drive don't get synchronized? Is it an open
>      > issue?  The directory is both exported and mounted using sync
>      > option.
> 
> You'll have to ask RedHat. 2.4.18-3 is *not* a stock Linux kernel.

Too bad the NFS in -3 was stock.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

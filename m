Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262886AbSKDXYl>; Mon, 4 Nov 2002 18:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSKDXYl>; Mon, 4 Nov 2002 18:24:41 -0500
Received: from mhost.enel.ucalgary.ca ([136.159.102.8]:6074 "EHLO
	mhost.enel.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262886AbSKDXYk>; Mon, 4 Nov 2002 18:24:40 -0500
Date: Mon, 4 Nov 2002 16:31:13 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: A POSIX Linux project?
Message-ID: <20021104163113.B13741@munet-d.enel.ucalgary.ca>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com> <3DC6FF60.2000100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DC6FF60.2000100@pobox.com>; from jgarzik@pobox.com on Mon, Nov 04, 2002 at 06:14:40PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 04, 2002  18:14 -0500, Jeff Garzik wrote:
> I wonder if any vendors, or independent groups, would be interested in 
> maintaining a POSIX compliancy patchkit for the Linux kernel?
> 
> IMO such a "POSIX Linux" project would be useful for several reasons. 
>  Overall, I think there is pressure from several directions to get all 
> sorts of POSIX APIs into the kernel.  On occasion, kernel hackers are 
> confronted with a situation where complete POSIX compliancy may mean a 
> compromise in some area, be it performance, security, API issues, code 
> cleanliness issues, etc.  Or simply that the POSIX-related code just 
> isn't ready to be merged into the mainline kernel yet.
> 
> The vendors also benefit by this, because the barrier to entry in 
> POSIX-related cases would be lowered, which would in turn satisfy the 
> demands of customers.  Which would in turn give the mainline kernel all 
> the software engineering benefits that come from a more reasoned and 
> gradual review and merge of new features.
> 
> Does something like this already exist?  This would need to be an open, 
> vendor-neutral project...

What about the existing POSIX test suite from X/Open?  I don't know what
the current license is, but it is certainly freely downloadable from
their website.  However, it is a pain in the a** to set up and run, so
a new version would definitely be welcome.

I would give you a URL, but I don't have access to my mail archives now.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

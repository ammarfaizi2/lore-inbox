Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271395AbRHOUNH>; Wed, 15 Aug 2001 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271398AbRHOUM5>; Wed, 15 Aug 2001 16:12:57 -0400
Received: from c2bapps2.btconnect.com ([193.113.209.22]:48825 "HELO
	c2bapps2.btconnect.com") by vger.kernel.org with SMTP
	id <S271395AbRHOUMn>; Wed, 15 Aug 2001 16:12:43 -0400
Date: Wed, 15 Aug 2001 21:13:03 +0100
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815211303.B1221@btconnect.com>
In-Reply-To: <20010815185005.A32239@sistina.com> <200108151755.f7FHtmTH013535@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108151755.f7FHtmTH013535@webber.adilger.int>; from adilger@turbolinux.com on Wed, Aug 15, 2001 at 11:55:48AM -0600
From: Joe Thornber <thornber@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

On Wed, Aug 15, 2001 at 11:55:48AM -0600, Andreas Dilger wrote:
> Sorry, I don't get the list email anymore, despite it telling me I'm
> subscribed (may be my fault, I don't know), please reply to l-k where
> I know I will see it.

Your mail is broken, I have tried to mail you many times over the last
few weeks from different email addresses and different ISP's.  Other
people have been trying too.  Did you notice a time when it suddenly
went quiet ?

> Saying you "need" the old versions of the installed tools to read the
> on disk data is bogus, IMNSHO.  You could easily have a flag which says
> "calculate the PE offsets using the old algorithm or the new algorithm".
> This could easily be keyed off of the presence/absence of the new
> pe_offset field in the pv_data struct on disk, and whether or not you
> actually have the misaligned PEs in the first place.

That assumes you have just two alternatives, this is not the case.

> When I talked to them last, the IBM EVMS folks didn't have any such
> problems correctly reading either the old (possibly offset) or new
> layouts with the same driver.

Then they don't understand the problem, though hopefully by the time they
release people will have migrated to the new format.

- Joe

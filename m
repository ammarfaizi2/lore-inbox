Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSHUEqg>; Wed, 21 Aug 2002 00:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317858AbSHUEqg>; Wed, 21 Aug 2002 00:46:36 -0400
Received: from brynhild.mtroyal.ab.ca ([142.109.10.24]:52970 "EHLO
	brynhild.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S317855AbSHUEqd>; Wed, 21 Aug 2002 00:46:33 -0400
Date: Tue, 20 Aug 2002 22:50:07 -0600 (MDT)
From: James Bourne <jbourne@mtroyal.ab.ca>
To: Christoph Hellwig <hch@infradead.org>
cc: jack@suse.cz, "Dmitry N. Hramtsov" <hdn@nsu.ru>,
       <linux-kernel@vger.kernel.org>
Subject: Re: vfsv0 quota patch
In-Reply-To: <20020820161046.A26295@infradead.org>
Message-ID: <Pine.LNX.4.44.0208202248020.30816-100000@skuld.mtroyal.ab.ca>
MIME-Version: 1.0
X-scanner: scanned by Inflex 1.0.12.2 - (http://pldaniels.com/inflex/)
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2002, Christoph Hellwig wrote:

> On Tue, Aug 20, 2002 at 04:26:20PM +0200, jack@suse.cz wrote:
> >   The computer will be probably offline for a while (as far as I know
> >   there are problems with electricity etc...). But you can also
> >   use -ac versions of kernel which should contain latest quota patches
> >   (actually more recent that on my ftp site...).
> 
> Or the quota patch from the 2.4.19 XFS split patches.  It might have some
> trivial rejects in Makefile/Config but should work without any problems.

You can find the vfsv0 quota patches for 2.4.18 and 2.4.19
at http://www.hardrock.org/kernel/

The 2.4.18 patch is from .cz (a while ago), and the 2.4.19 is a diff I
took after applying and very little merging (IIRC) from the 2.4.18 patch
to the base 2.4.19 kernel.

I have done some prelim. testing it the 2.4.19 patch does seem to work fine.

Regards
James Bourne

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************


"There are only 10 types of people in this world: those who
understand binary and those who don't."



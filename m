Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGZJ4m>; Fri, 26 Jul 2002 05:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317564AbSGZJ4m>; Fri, 26 Jul 2002 05:56:42 -0400
Received: from p3EE3E50F.dip.t-dialin.net ([62.227.229.15]:29956 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S317550AbSGZJ4L>;
	Fri, 26 Jul 2002 05:56:11 -0400
Date: Fri, 26 Jul 2002 11:48:14 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020726114814.A12251@sistina.com>
Reply-To: mauelshagen@sistina.com
References: <20020725153944.A8060@sistina.com> <20020725153419.A12435@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020725153419.A12435@infradead.org>; from hch@infradead.org on Thu, Jul 25, 2002 at 03:34:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:34:19PM +0100, Christoph Hellwig wrote:
> On Thu, Jul 25, 2002 at 03:39:44PM +0200, Heinz J . Mauelshagen wrote:
> > 
> > All,
> > have send an LVM 1.0.5 patch to Marcelo directly which addresses:
> > 
> > - an OBO error accessing the vg array
> > - SMP lock fixes
> > - using blk_ioctl()
> > - indenting
> 
> Any estimate when Stephen's non-broken pvmove implementaion will be merged?

Probably next month if I get time for that.

-- 

Regards,
Heinz    -- The LVM Guy --

*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbRDLJob>; Thu, 12 Apr 2001 05:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133090AbRDLJoV>; Thu, 12 Apr 2001 05:44:21 -0400
Received: from hermes.sistina.com ([208.210.145.141]:54020 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S133088AbRDLJoJ>;
	Thu, 12 Apr 2001 05:44:09 -0400
Date: Thu, 12 Apr 2001 10:44:02 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@Sistina.com>
To: Christoph Hellwig <hch@caldera.de>
Cc: Jonathan Lahr <lahr@sequent.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: block device snapshot capability
Message-ID: <20010412104402.A25018@sistina.com>
Reply-To: Mauelshagen@Sistina.com
In-Reply-To: <20010411142654.A23996@w-lahr.des.sequent.com> <200104112140.XAA05309@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104112140.XAA05309@ns.caldera.de>; from hch@caldera.de on Wed, Apr 11, 2001 at 11:40:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 11:40:36PM +0200, Christoph Hellwig wrote:
> In article <20010411142654.A23996@w-lahr.des.sequent.com> you wrote:
> 
> > Hello all,
> >
> > Is anyone aware of ongoing development to provide the capability 
> > to take a snapshot of a block device?
> 
> It's part of Linux-LVM since version 0.8 and thus part of Linux 2.4.

You need to get the recent LVM 0.9.1 Beta 7 software *and* to patch your
kernel as well, because that'll fix some snapshot related flaws.

> 
> 	Christoph
> 
> -- 
> Of course it doesn't work. We've performed a software upgrade.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSBEKTw>; Tue, 5 Feb 2002 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBEKTm>; Tue, 5 Feb 2002 05:19:42 -0500
Received: from pD956D422.dip.t-dialin.net ([217.86.212.34]:15876 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S289369AbSBEKTe>;
	Tue, 5 Feb 2002 05:19:34 -0500
Date: Tue, 5 Feb 2002 11:18:37 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Message-ID: <20020205111837.A1571@sistina.com>
Reply-To: mauelshagen@sistina.com
In-Reply-To: <20020201100303.A14415@sistina.com> <Pine.LNX.3.96.1020204171446.31056B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.96.1020204171446.31056B-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Feb 04, 2002 at 05:16:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2002 at 05:16:27PM -0500, Bill Davidsen wrote:
> On Fri, 1 Feb 2002, Heinz J . Mauelshagen wrote:
> 
> > The LVM2 sofware no longer uses a particular driver which is just
> > usable for its own purpose.
> > It rather accesses a different, so-called 'device-mapper' driver, which
> > implements a generic volume management service for the Linux kernel by
> > supporting arbitray mappings of address ranges to underlying block devices.
> > Because this is a generic service rather than an application within the kernel,
> > it is open to be used by multiple LVM implementations (for eg. EVMS could be
> > ported to use it :-)
> 
> Interesting concept, but something like the "smitZ" interface to RAID and
> sizing would be really nice to reduce training effort. Since IBM is
> pushing Linux, take this as a HINT.

Hint is to user interface only or to in kernel ones as well?

> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.

-- 

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

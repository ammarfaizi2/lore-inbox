Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135851AbREKOcz>; Fri, 11 May 2001 10:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136772AbREKOch>; Fri, 11 May 2001 10:32:37 -0400
Received: from hermes.sistina.com ([208.210.145.141]:64008 "HELO sistina.com")
	by vger.kernel.org with SMTP id <S135851AbREKOcQ>;
	Fri, 11 May 2001 10:32:16 -0400
Date: Fri, 11 May 2001 16:27:45 +0000
From: "Heinz J. Mauelshagen" <Mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: LVM 1.0 release decision
Message-ID: <20010511162745.B18341@sistina.com>
Reply-To: Mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As most of you probably know, we've got criticism a couple of weeks ago about
our Linux kernel patch policy causing the LVM vanilla kernel code to differ
from the one we release directly.

In order to avoid this difference we provide smaller patches more often now.
We have started already with a subset of about 50 necessary patches.

Even though we get kind support from Alan Cox to get those QAed and integrated,
the pure amount of patches will take at least a couple of weeks to make it in.

This leads to the dilemma, that trying to avoid further differences between
our LVM releases and the stock kernel code would force us into postponing
the pending LVM 1.0 release accordingly which OTOH is incovenient for the LVM
user base.

In regard to this situation we'ld like to know about your oppinion on
the following request:
is it acceptable to release 1.0 soon *before* all patches to reach the 1.0 code
status are in vanilla (presumed that we provide them with our release as we
always did before)?

We'll gather your answers for some days and will send the conclusion
to the lists.

Thanks for your support!

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

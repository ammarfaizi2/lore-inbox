Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131016AbQLLLlh>; Tue, 12 Dec 2000 06:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQLLLlQ>; Tue, 12 Dec 2000 06:41:16 -0500
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:64389 "EHLO
	d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S131016AbQLLLlL>; Tue, 12 Dec 2000 06:41:11 -0500
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: "Jon Hulatt" <jon@atomichamster.org>
cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Message-ID: <802569B3.003D5852.00@d06mta06.portsmouth.uk.ibm.com>
Date: Tue, 12 Dec 2000 11:09:16 +0000
Subject: Re: cpu stepping
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stepping is Intel teminology for chip revisions - possibly other
manufacturers have used the same terminology.  Intel documents the fixes,
or rather the bugs and work-arounds, for each stepping level in the
addendum to the particular processor's reference manual. Probably, I
haven't checked, this info is available in PDF format from the INTEL
website (http://www.intel.com).

IBM terminology for the equivalent of stepping level  is EC level
(engineering change level).

To understand the fine detail of the intel stepping levels, in particular
the work-arounds, you'll need to be familiar with the processor
architecture to the extent an assembler programmer would be.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


"Jon Hulatt" <jon@atomichamster.org> on 12/12/2000 10:45:50

Please respond to "Jon Hulatt" <jon@atomichamster.org>

To:   "Linux Kernel" <linux-kernel@vger.kernel.org>
cc:
Subject:  cpu stepping




hi,

sorry to ask this here but i'm finding difficulty getting this info
elsewhere...

I'm not an assembly programmer and i know little about cpu's. it's a hole
in
my knowledge i guess. i'm looking for some technical introduction doc to
explain what diff. aspects of cpu do, what is stepping and all that.
especially for intel but also for other architectures.

Thanks

Jon

 - att1.htm



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

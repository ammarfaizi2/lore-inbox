Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317465AbSGEMpq>; Fri, 5 Jul 2002 08:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSGEMpp>; Fri, 5 Jul 2002 08:45:45 -0400
Received: from B5642.pppool.de ([213.7.86.66]:31756 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317465AbSGEMpo>; Fri, 5 Jul 2002 08:45:44 -0400
Subject: Re: IBM Desktar disk problem?
From: Daniel Egger <degger@fhm.edu>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
References: <Pine.LNX.4.43.0207051217160.8506-100000@cibs9.sns.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 14:50:20 +0200
Message-Id: <1025873421.16768.20.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-07-05 um 12.27 schrieb venom@sns.it:

> Has anyone had a similar experience with this kind of disks?

I suspect it's the usual IBM crap phenomenon; three discs died in the
last two weeks (1 DTLA and 2 IC35) here, that's a whooping 33% of the
IBM drives I use. No TCQ involved and on one not even Linux and the
other two had two different stable 2.4 kernels.

<problemdescription>
The drives started developping bad sectors, one of the drives to a 
degree over 10% of the total amount sectors; according to IBM it's
a "software failure" of the device driver and can be fixed by what
they call "Erase Disc" i.e. a lowlevel format. Needless to say I
tried this on one drive and the problems started again one week 
later. The drives are between 3 and 12 months old and are now on
their way to IBM.
</problemdescription>

<advise>
Buy decent drives, then get DriveFitnessTest (DFT) from their website
and check the harddrives, note the TRC number, request an RMA on their
website and ship the drives as soon as possible to IBM. Wait for the
replacement drives and sell them ASAP on Ebay to some freaks who don't
give a dime about data security.
</advise>

-- 
Servus,
       Daniel


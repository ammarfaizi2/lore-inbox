Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSGEPfu>; Fri, 5 Jul 2002 11:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGEPeW>; Fri, 5 Jul 2002 11:34:22 -0400
Received: from B5578.pppool.de ([213.7.85.120]:46349 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317484AbSGEPeR>; Fri, 5 Jul 2002 11:34:17 -0400
Subject: Re: IBM Desktar disk problem?
From: Daniel Egger <degger@fhm.edu>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Thunder from the hill <thunder@ngforever.de>, venom@sns.it,
       linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020705152010.00aa2af0@pop.cus.cam.ac.uk>
References: <1025873421.16768.20.camel@sonja.de.interearth.com> 
	<5.1.0.14.2.20020705152010.00aa2af0@pop.cus.cam.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 17:32:27 +0200
Message-Id: <1025883147.17269.24.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-07-05 um 16.29 schrieb Anton Altaparmakov:

> Um, the solution is already known. Upgrade the firmware on the drive, low 
> level format if the drive thinks there are bad sectors, and be happy. At 
> least it worked for me...
 
> The very first question when making a support call for my broken deathstar 
> was "Have you installed the firmware update?" "No." "Download it here and 
> install, come back if it still doesn't work."
 
> I never thought it would work but it did! It seems there is something wrong 
> in the firmware the drives are shipped with and some suppliers obviously 
> know this considering my experience... When I was running the DFT test 
> utility it was telling me my drive is broken and needs to be returned. 
> After the firmware update the same test utility passed all tests repeatedly!

This is unacceptable; if my problem is really fixable by a firmware
upgrade IBM should have pushed this very upgrade publically after they
started to learn about the problem. Saying "Hey, BTW: if you had this
firmware version you would never have experienced your data loss" is
a very strong argument to never buy any IBM hardware again.

Still, the techsupport insisted on a software problem and didn't mention
a firmware upgrade; up to now I didn't even knew such a thing exists.
And letting customers lowlevel-format a drive, restore their data,
and experience the same problem again a week later is anything but
professional.

Though the timespan makes me curious: Why is there a magnitude
difference in runtime between the first problem on a fresh drive
and after a lowlevel format?

-- 
Servus,
       Daniel


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFTQfO>; Thu, 20 Jun 2002 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSFTQfN>; Thu, 20 Jun 2002 12:35:13 -0400
Received: from mail.viewcast.com ([66.21.70.195]:62698 "EHLO mail.viewcast.com")
	by vger.kernel.org with ESMTP id <S315218AbSFTQfL>;
	Thu, 20 Jun 2002 12:35:11 -0400
From: "Scott Tillman" <tillman@viewcast.com>
To: "Dave Jones" <davej@suse.de>
Cc: "Martin Dalecki" <dalecki@evision-ventures.com>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Garet Cammer" <arcolin@arcoide.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Need IDE Taskfile Access
Date: Thu, 20 Jun 2002 12:36:26 -0400
Message-ID: <CBELJEJGBEIGHCIMEDHNGEAICJAA.tillman@viewcast.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20020620005259.V29373@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder about the legality of including such a port in the
> mainline kernel.
> The IDE restriction sounds like it definitly comes under the
> 'circumventing an access control' clause of the DMCA.

Well, IANAL, but if you are referring to the IDE's security mode commands,
they are just the access method...you still need the actual key.  If you
want to count that then things like a DMA controller, or a mouse could be
considered circumvention devices.  I think of it like the lock on a door.
The lock commands are the lock, the code to access the commands is the
*user* of the key.  You still need to have the actual key to unlock
anything.  What the DMCA is geared to prevent is the "opening" of the lock
by removing the hinges.

circumvention: To go around; bypass;
(to circumvent != to use) in fact they are basically antonyms.

The IDE security commands are no more a "circumvention device" than you are.
You use keys to provide access to things behind locks.  It uses keys to
provide access to things behind locks.  So, if it is illegal for me to make
code which can, when provided a key, unlock my hard drive then...Hey, I've
got a great idea...let's arrest all pregnant women for manufacturing a
circumvention device.

Sorry...It just irks me to see this knee-jerk reaction in fear of the DMCA,
whether it's called for or not.

-Scott Tillman aka SpeedBump


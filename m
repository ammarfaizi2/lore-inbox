Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292896AbSCJIYM>; Sun, 10 Mar 2002 03:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292915AbSCJIYD>; Sun, 10 Mar 2002 03:24:03 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:19880 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S292896AbSCJIXt>; Sun, 10 Mar 2002 03:23:49 -0500
Message-Id: <200203100823.JAA14203@cave.bitwizard.nl>
Subject: Re: Suspend support for IDE
In-Reply-To: <E16joxm-0002g6-00@the-village.bc.nu> from Alan Cox at "Mar 9, 2002
 10:05:14 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sun, 10 Mar 2002 09:23:44 +0100 (MET)
CC: Pavel Machek <pavel@ucw.cz>, dalecki@evision-ventures.com,
        kernel list <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Also there is the some fun about buggy drives and power up happenings. On no
> account can you issue any command that might touch the platter unless you
> know the drive is at full running speed when spinning up certain old drives
> because the firmware in some cases forgets to check the drive is at speed
> and you physically destroy the disk over time. Thankfully thats old old
> drives (540Mb quantum if I remember rightly)

That could be 1.6G or 2.5G WD drives. AC31600, AC32500. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 

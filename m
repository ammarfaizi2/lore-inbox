Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312449AbSDJOcT>; Wed, 10 Apr 2002 10:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313182AbSDJOcR>; Wed, 10 Apr 2002 10:32:17 -0400
Received: from [62.245.135.174] ([62.245.135.174]:51110 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313176AbSDJOcM>;
	Wed, 10 Apr 2002 10:32:12 -0400
Message-ID: <3CB44CE5.1EEAB8B5@TeraPort.de>
Date: Wed, 10 Apr 2002 16:32:05 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: jjasen1@umbc.edu
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Tyan S2462 reboot problems
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/10/2002 04:32:04 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/10/2002 04:32:11 PM,
	Serialize complete at 04/10/2002 04:32:11 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Tyan S2462 reboot problems
> 
> From: John Jasen (jjasen1@umbc.edu)
> Date: Tue Apr 09 2002 - 15:20:17 EST
> 
> 
> > No, I doubt this has anything to do with Linux. I have a S2460 (which his
> > corrected post says he has), which does not power down under linux, and

 No correction from me :-) For me it is still s2462 (aka Thuder K7).

> > *never* warm boots cleanly. It does power down under windows, so I assume
> > ACPI powerdown works and APM does not. I have gone under the assumption that
> > a BIOS upgrade will fix this, but that involves putting a floppy into the box,
> > so I haven't done it yet. The warm boot problems consist of either a hang
> > after POST (but before bootloader, OS irrelevent), or really bad video

 That sounds like it.

> > corruption. I don't know if it boot with the video corruption, I've never let
> > it try.
> 
> I did update to the new BIOS for the 246x (I can never keep them straight
> either), and that did help some with the halt and reboot problems I was
> having.
> 
John,

 do you recall from which to which version of the BIOS your upgrade
went? The upgrade procedure for the s2462 implies a W98 boot floppy
(never ever seen one of those :-) and it also strongly reccommends
flashing the CMOS memory. As this involves playing with jumpers on the
MB and I have 9 of them screwed into a rack, I hesitate to go that
path.... As I wrote the MBs are at 2.09 and the newest version from Tyan
is 2.10, with a not very interesting list of fixes/enhancements.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759

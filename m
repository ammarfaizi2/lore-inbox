Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbTAOTxL>; Wed, 15 Jan 2003 14:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbTAOTxL>; Wed, 15 Jan 2003 14:53:11 -0500
Received: from office-NAT.rockwellfirstpoint.com ([199.191.58.7]:62846 "EHLO
	ecsmtp01.rockwellfirstpoint.com") by vger.kernel.org with ESMTP
	id <S266924AbTAOTxK>; Wed, 15 Jan 2003 14:53:10 -0500
In-Reply-To: <OFEC2D1079.106A6C04-ON86256C91.00739206-86256C91.0073544D@LocalDomain>
Subject: Re: i810 sound starts and stops for 2.4.XX and i845PE chipset
To: linux-kernel@vger.kernel.org
Cc: edward.kuns@rockwellfirstpoint.com
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFFA31EAD2.3942B973-ON86256CAF.006D4FCA-86256CAF.006E0AFE@rockwellfirstpoint.com>
From: edward.kuns@rockwellfirstpoint.com
Date: Wed, 15 Jan 2003 13:59:43 -0600
X-MIMETrack: Serialize by Router on ECSMTP01/EC/Rockwell(Release 5.0.11  |July 24, 2002) at
 01/15/2003 02:02:03 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last weekend I tried out 2.4.21-pre3-ac2 and that resolved the sound
problems I was having with i810 audio.  Since moving the sound driver
itself back to an earlier release did not make the difference, I conclude
that the IRQ steering code was updated between 2.4.18 and the latest
releases.  This is with the i845PE chipset on the Gigabyte 8PE667 Ultra
motherboard (aka P4 Titan 667 Ultra) .

It's possible that this IRQ fix was present in an earlier load.  I had
separate issues with 2.4.20-*** loads that prevented this computer from
booting.  I'm pretty sure that a fix included in 2.4.21-pre3 resolved that
problem.

      Eddie

--
Edward Kuns
Technical Staff Member
Rockwell FirstPoint Contact
300 Bauman Ct
Wood Dale, IL  60191
Phone: +1-630-227-8070
Fax: +1-630-227-8040
edward.kuns@rockwellfirstpoint.com
www.rockwellfirstpoint.com

This e-mail is intended solely for the person or entity to which it is
addressed and may contain confidential or privileged material.  Any
duplication,  dissemination, action taken in reliance upon, or other use of
this information by persons or entities other than the intended recipient
is prohibited and may violate applicable law.  If this e-mail has been
received in error, please notify the sender and delete the information from
your system.




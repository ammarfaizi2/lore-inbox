Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311418AbSCMWjp>; Wed, 13 Mar 2002 17:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311422AbSCMWjf>; Wed, 13 Mar 2002 17:39:35 -0500
Received: from serval.noc.ucla.edu ([169.232.10.12]:42203 "EHLO
	serval.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S311418AbSCMWjZ>; Wed, 13 Mar 2002 17:39:25 -0500
From: "Amir Kazerouninia" <amirk@ucla.edu>
To: <linux-kernel@vger.kernel.org>
Subject: New kernel reboots machine during boot up
Date: Wed, 13 Mar 2002 14:36:18 -0800
Message-ID: <ECEBJPOCCIGHNECIGEPDEEGDCAAA.amirk@ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	The kernel I just compiled is the 2.4.18 kernel. LILO deals with the large
drive fine when booting the previous 2.2.19 kernel. I compiled the new one
from scratch with no networking support and very little else. The problem
basically occurs right at boot, it doesn't matter if I use a floppy to boot
or my haddrive. The problem with the harddrive is that I'll get a loading
vmlinuz-2.4.18......... and then it reboots. I haven't been able to pause it
to get a clear picture of what is happening. The floppy is a little easier
because what happens is that it says Loading, gives a series of dots and
then reboots. Any suggestions would be greatly appreciated. Thanks in
advance for suggestions.
	I am not on the mailing list, so please direct responses to my personal
email amirk@ucla.edu thanks

Amir Kazerouninia
UCLA Chemistry & Biochemistry
eMail: amirk@ucla.edu
Cell: (818) 929 7559
Work: (310) 825 4916



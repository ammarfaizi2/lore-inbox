Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSLAT1m>; Sun, 1 Dec 2002 14:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSLAT1l>; Sun, 1 Dec 2002 14:27:41 -0500
Received: from 205-158-62-68.outblaze.com ([205.158.62.68]:63759 "HELO
	spf0.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262387AbSLAT1k>; Sun, 1 Dec 2002 14:27:40 -0500
Message-ID: <20021201193453.29958.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Steven Barnhart" <lilobooter@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Dec 2002 14:34:53 -0500
Subject: Linux v2.5.50-sb1
X-Originating-Ip: 65.150.222.190
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have released a patch-set for 2.5.50: 2.5.50-sb1. This is my first
patch-set so please tell me what to do differently, and such and please
test it! Feel free to e-mail me with your comments. This patch contains
some minor fixes and such including that annoying quirks.c bug. Have fun
hacking!

Download at:
http://members.lycos.co.uk/sbarn/linux/patches/2.5.50-sb1.gz

Changes from 2.5.49-sb1 to 2.5.50-sb1:

<steven@sbarn.net>:
  o Linux v2.5.50-sb1
  o Linux v2.5.50-sb1
  o ISA-SOUND_op13sa2.c.patch
  o permission-fixes-onvfat.patch
  o PCI-quirks.c.patch
  o Merge Linux v2.5.50 into Linux v2.5.49-sb2
  o pnpbios-patch2
  o phpbios-corecpatch
  o 2.5.49-mm1
  o bkpatch1
  o wd-2.5.49-patch

Greg Kroah-Hartman <greg@kroah.com>:
  o LSM: change if statements into something more readable for the arch/* files
  o LSM: change if statements into something more readable for the kernel.*
    files
  o LSM: change if statements into something more readable for the ipc/*, mm/*,
    and net/* files
  o LSM: change if statements into something more readable for the fs/* files
  o LSM: fix conversions in hugetlbfs that I missed in the last merge

---------
Steven Barnhart
SBarn03@mailbolt.com
GnuPG Fingerprint: 24AA 498C D399 26F5 6034  ED1E 0100 96C7 A89F 64A8
Freelance Open Source Journalist

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze

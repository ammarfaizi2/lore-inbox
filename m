Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281569AbRKPV5W>; Fri, 16 Nov 2001 16:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281566AbRKPV5M>; Fri, 16 Nov 2001 16:57:12 -0500
Received: from apollo.wizard.ca ([204.244.205.22]:45586 "HELO apollo.wizard.ca")
	by vger.kernel.org with SMTP id <S281561AbRKPV46>;
	Fri, 16 Nov 2001 16:56:58 -0500
Subject: Current Max Swap size? Performance issues
From: Michael Peddemors <michael@wizard.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 16 Nov 2001 14:02:31 -0800
Message-Id: <1005948151.10803.18.camel@mistress>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all of the latest VM, again the question is asked...  Best way to
set up swap now..

For 2 GIG memory...
Channel 0 is RAID 1 SCSI
Channel 2 is RAID 1+0 SCSI
Hardware Raid

Shoudl it be?

2 GIG swap partition (Is this still the limit?)
Dual 2 GIG swaps on seperate channels?
Dual 2 GIG swap files on same channel?
(Assuming that the channel is different than the channel using the bulk
of I/O)

-- 
"Catch the Magic of Linux..."
--------------------------------------------------------
Michael Peddemors - Senior Consultant
LinuxAdministration - Internet Services
NetworkServices - Programming - Security
Wizard IT Services http://www.wizard.ca
Linux Support Specialist - http://www.linuxmagic.com
--------------------------------------------------------
(604)589-0037 Beautiful British Columbia, Canada


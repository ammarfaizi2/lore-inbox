Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269628AbRHHXIF>; Wed, 8 Aug 2001 19:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269620AbRHHXHw>; Wed, 8 Aug 2001 19:07:52 -0400
Received: from sm10.texas.rr.com ([24.93.35.222]:6875 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S269619AbRHHXHn>;
	Wed, 8 Aug 2001 19:07:43 -0400
From: "Rob" <rwideman@austin.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: FW: tulip.o during 2.4.7 compile
Date: Wed, 8 Aug 2001 18:10:07 -0500
Message-ID: <LHEGJICMMCCGOHKDFALMEENFCAAA.rwideman@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n/m wrong mailing list AND i found out the answer, in the description it is
labeled as tulip.o
Rob

-----Original Message-----
From: Rob [mailto:rwideman@austin.rr.com]
Sent: Wednesday, August 08, 2001 6:06 PM
To: linux-kernel@vger.kernel.org
Subject: tulip.o during 2.4.7 compile


I am currently running RH 7.1 and trying to compile the 2.4.7 kernel. My
Linksys (lne100tx) NIC is currently running the tulip module. In the Nic
section of the "make menuconfig" of the configuration i can only find an
option of "DECchip Tulip (dc21x4x) PCI support" which states that "some"
Linksys cards use.  It never specifies the name of the module other than
config_tulip in the description.  Is this the correct module for the NIC?
Rob


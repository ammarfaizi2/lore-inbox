Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262031AbSIYRPQ>; Wed, 25 Sep 2002 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262032AbSIYRPQ>; Wed, 25 Sep 2002 13:15:16 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:49297 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S262031AbSIYRPP> convert rfc822-to-8bit;
	Wed, 25 Sep 2002 13:15:15 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: tons of "Warning - running *really* short on DMA buffers" messages - 2.4.19, aic7xxx
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 25 Sep 2002 12:20:31 -0500
Message-ID: <2B45A04D8F18D947A400F0850CE3B53B061692@umr-mail7.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: tons of "Warning - running *really* short on DMA buffers" messages - 2.4.19, aic7xxx
Thread-Index: AcJkt9i6ZvT/Js73Eda/QABQVgAgFQ==
From: "Neulinger, Nathan" <nneul@umr.edu>
To: <Linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anything that can be done about these? Running 2.4.19 on a
piii-800, 512MB, scsi hardware raid.

Seeing tons of these messages (flooding syslogs) whenever I do much I/O
to the drives.

Is there any vm tuning that can be done?

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216

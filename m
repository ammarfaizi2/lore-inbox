Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131686AbQLVVEW>; Fri, 22 Dec 2000 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131943AbQLVVEM>; Fri, 22 Dec 2000 16:04:12 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:37130 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131686AbQLVVEC>;
	Fri, 22 Dec 2000 16:04:02 -0500
Message-ID: <00cd01c06c56$740a6740$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: hd disk devices
Date: Fri, 22 Dec 2000 15:33:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following hd devices in /dev.

hda 3,0
hdb 3,64
hdc 22,0
hdd 22,64
hde 33,0
hdf 33,64
hdg 34,0
hdh 34,64

How do I go about making devices for hdi, hdj, hdk, hdl, hdm, hdn, etc ?

i.e. which major and minor numbers do I use?

Regards,
Charles Wilkins

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

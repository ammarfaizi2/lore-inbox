Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132307AbRA0JiM>; Sat, 27 Jan 2001 04:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132389AbRA0JiD>; Sat, 27 Jan 2001 04:38:03 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:62963 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S132307AbRA0JiA>; Sat, 27 Jan 2001 04:38:00 -0500
Message-ID: <3A7296E1.43DDF06A@Home.com>
Date: Sat, 27 Jan 2001 04:37:37 -0500
From: Shawn Starr <Shawn.Starr@Home.com>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mlord@pobox.com, linux-kernel@vger.kernel.org
Subject: [PROBLEM]: Under 2.4.X hdparm displays device names backwards? ;)
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what the device names are:

hda: FUJITSU MPE3064AT, ATA DISK drive
hdb: WDC AC32500H, ATA DISK drive

here's what they are with hdparm:

dev/hda:

 Model=UFIJST UPM3E60A4 T                      , FwRev=DE0--380,
SerialNo=            50256499

/dev/hdb:

 Model=DW CCA2305H0                            , FwRev=210.H721,
SerialNo=DWW-3T06418895 2

hehe, might wanna fix that ;-)

Shawn.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

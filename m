Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269257AbRH0Vzp>; Mon, 27 Aug 2001 17:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269318AbRH0Vzf>; Mon, 27 Aug 2001 17:55:35 -0400
Received: from mail.cdlsystems.com ([207.228.116.20]:59658 "EHLO
	cdlsystems.com") by vger.kernel.org with ESMTP id <S269257AbRH0Vz0>;
	Mon, 27 Aug 2001 17:55:26 -0400
Message-ID: <00c101c12f42$921d3820$160e10ac@hades>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel@vger.kernel.org>
Subject: Files missing from filesystem?  (2.4.9)
Date: Mon, 27 Aug 2001 15:52:30 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Return-Path: mcuss@cdlsystems.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all

I just upgraded the kernel on our server to 2.4.9 last friday.  We made some
changes to some script files that night, and discovered that the changes
were gone this morning.  A check of the backup tape that ran friday night
verifies that the changes were made, and a poll around the office yields
that noone changed them....

I had a dig through the kernel log and turned up the following message:

Aug 26 03:02:37 chaos kernel: (scsi0:A:0:0): Locking max tag count at 64

Does this have anything to do with it?  It seemed wierd to me - I had never
seen it before.  If anyone can enlighten me as
to what it means I'd really appreciate it.

Thanks

Mark

Mark Cuss, B. Sc.
Junior Real Time Systems Analyst
CDL Systems Ltd
3553 - 31 Street NW
Calgary, Alberta
(403) 289-1733 ext 226
mcuss@cdlsystems.com



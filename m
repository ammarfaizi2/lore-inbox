Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbRGALlO>; Sun, 1 Jul 2001 07:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbRGALlE>; Sun, 1 Jul 2001 07:41:04 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:172 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S265108AbRGALku>; Sun, 1 Jul 2001 07:40:50 -0400
Message-ID: <016f01c10222$ab9fba40$b6562341@cfl.rr.com>
From: "Mike Black" <mblack@csihq.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.6-pre6 ext3 message
Date: Sun, 1 Jul 2001 07:40:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 2.4.6-pre6 and ext3-2.4-0.0.8-246p5 (had to to hand patch a little).

 This message popped up on an idle system -- there were no "odd" cronjobs
 scheduled around this time.  Nobody was logged on.  System had been up for
a
 little over a day...first time seeing any messages like this.
 The source doesn't indicate whether this is serious or just informational.

 Jun 30 15:58:55 yeti kernel: journal_commit_transaction: odd - more buffers

 This is on a RAID1 dual IDE disk setup.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSBSR5L>; Tue, 19 Feb 2002 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBSR5A>; Tue, 19 Feb 2002 12:57:00 -0500
Received: from msp-dsl-42.datasync.com ([208.164.149.42]:64643 "HELO
	gulf.gulfsales.com") by vger.kernel.org with SMTP
	id <S291547AbSBSR44>; Tue, 19 Feb 2002 12:56:56 -0500
From: "Glover George" <dime@gulfsales.com>
To: <linux-kernel@vger.kernel.org>
Subject: st0: Block limits 1 - 16777215 bytes.
Date: Tue, 19 Feb 2002 11:57:07 -0600
Message-ID: <000201c1b96e$d8921d00$0300a8c0@yellow>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing mysterious lockups since upgrading to kernel
2.4.17.  Looking in the /var/log/messages I hadn't seen anything
suspicious until now.  I guess the machine hasn't had time to write this
to disk except every now and then.  The message

Feb 19 11:29:55 butler kernel: st0: Block limits 1 - 16777215 bytes.

I notice this after rebooting after the crash.  So I tried manually
doing a tar to the tape drive and was able to successfully lock the
machine up.  Can someone help me understand this and if it is simply a
limit problem, why would the machine lock up?

Thank you.

Glover George
Systems/Networks Admin
Gulf Sales & Supply, Inc.
(228) 762-0268
dime@gulfsales.com
http://www.gulfsales.com
 


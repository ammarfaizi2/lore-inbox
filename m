Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTBER4t>; Wed, 5 Feb 2003 12:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBER4r>; Wed, 5 Feb 2003 12:56:47 -0500
Received: from smtp.cs.curtin.edu.au ([134.7.1.1]:6552 "EHLO
	smtp.cs.curtin.edu.au") by vger.kernel.org with ESMTP
	id <S262380AbTBER4p>; Wed, 5 Feb 2003 12:56:45 -0500
Message-ID: <007b01c2cd41$0db1f550$64070786@synack>
From: "David Shirley" <dave@cs.curtin.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: SMP 2.4.20 box crashed
Date: Thu, 6 Feb 2003 02:04:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have a 2.4.20 Dual Athlon. It has been working
fine for quite some time, however today it just crashed, 
i could ping it fine, but no tcp connections were getting
through, also the console was dead, i couldn't even break 
out of the screen blanker to see what the problem was.

CTRL-ALT-DEL didn't do anything either, had to hard reset
it.

Logs dont show anything, just the usual "sa" cron job as the 
last entry. Is there anyway to find out exactly why it crashed?

Btw: this was a Redhat 7.3, and its main job was NFS.
If you need more info just ask.

Thanks
Dave



/-----------------------------------
David Shirley
System's Administrator
Computer Science - Curtin University
(08) 9266 2986
-----------------------------------/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310937AbSCHQUv>; Fri, 8 Mar 2002 11:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310934AbSCHQUl>; Fri, 8 Mar 2002 11:20:41 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:62084 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S310933AbSCHQUe>; Fri, 8 Mar 2002 11:20:34 -0500
Date: Fri, 08 Mar 2002 08:17:48 -0800
From: Jeff Jenkins <jefreyr@pacbell.net>
Subject: Thread registers dumped to core-file
To: linux-kernel@vger.kernel.org
Message-id: <HFEPKLGPJDEHEGCKLKCCMEDLCCAA.jefreyr@pacbell.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was chatting with the GDB folks, and they mentioned there is no code in
the kernel which
will dump *all* thread registers to a core file.  Anyone have such code that
could be used in a patch?

Being able to get at the state of all threads in a process at core-dump time
is invaluable!
Anyone else been griping about this?

Rah!

-- jrj



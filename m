Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQKIRmd>; Thu, 9 Nov 2000 12:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQKIRmX>; Thu, 9 Nov 2000 12:42:23 -0500
Received: from hvmta03-ext.us.psimail.psi.net ([38.202.36.27]:62657 "EHLO
	hvmta03-stg.us.psimail.psi.net") by vger.kernel.org with ESMTP
	id <S129595AbQKIRmE>; Thu, 9 Nov 2000 12:42:04 -0500
From: "Chris Swiedler" <chris.swiedler@sevista.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: getting a process name from task struct
Date: Thu, 9 Nov 2000 12:45:36 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNCEEHCPAA.chris.swiedler@sevista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to get a process's name / full execution path (from
kernelspace) given only a task struct? I can't find any pointers to this
information in the task struct, and I don't know where else it might be. ps
seems to be able to get the process name, but that's from userspace.
Apologies in advance if this is a stupid question.

chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

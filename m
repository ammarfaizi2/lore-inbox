Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131618AbRCOC1H>; Wed, 14 Mar 2001 21:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131621AbRCOC05>; Wed, 14 Mar 2001 21:26:57 -0500
Received: from [203.63.54.174] ([203.63.54.174]:22287 "EHLO
	firewall.networkharmoni.com.au") by vger.kernel.org with ESMTP
	id <S131618AbRCOC0p>; Wed, 14 Mar 2001 21:26:45 -0500
Message-ID: <002d01c0acf6$df701210$9b363fcb@networkharmoni.com.au>
From: "Matthew Love" <matthew@networkharmoni.com.au>
To: <linux-kernel@vger.kernel.org>
Subject: determining max process slots at runtime
Date: Thu, 15 Mar 2001 10:23:07 +0800
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

hi

is it possible to determine the maximum number of processes at runtime?
I know about #define NR_TASKS, but that might not work if the binary is run
on a different machine than the one the program was compiled on.

PS
 I'm not looking for the maximum number of processes per user. I've found
that
by getrusage().

TIA

matthew love
software engineer
networkharmoni pty ltd.




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130499AbQKUXdr>; Tue, 21 Nov 2000 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbQKUXdi>; Tue, 21 Nov 2000 18:33:38 -0500
Received: from ftp.webmaster.com ([209.10.218.74]:37617 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S130499AbQKUXdU>; Tue, 21 Nov 2000 18:33:20 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: Strange thing (/dev/random)
Date: Tue, 21 Nov 2000 15:03:19 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKIEJHMAAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I noticed something odd with the entropy pool in 2.4.0-test11. If a normal
user does a 'sysctl -A', the entropy pool empties. I'm not sure why, but it
sounds like this isn't a good thing from a security standpoint.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVF2PgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVF2PgW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVF2PgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:36:22 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:54507 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261416AbVF2Pfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:35:43 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: RTNETLINK Failure 2.6.12.1
Date: Wed, 29 Jun 2005 10:40:05 -0500
Message-ID: <000001c57cc0$d75823d0$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.12.1 when the loopback device is being initialized, I get the
following:

RTNETLINK: answers: File exists

However, with 2.6.11.11, I don't get this.  I've searched the net via
google as well as the kernel archives, with no luck.  Could someone give
me a clue as to what I need to do to fix this?  My system is a Linux
>From Scratch 6.0 plus BLFS updates.  Works without error with <=
2.6.11.11, but gives the above error with >= 2.6.12.  However, even with
this error, the system seems to be working just fine.

Please CC me as I'm not a member of this mailing list.

Thanks,
Steve



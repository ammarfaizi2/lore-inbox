Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTE2FVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTE2FVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:21:32 -0400
Received: from marstons.services.quay.plus.net ([212.159.14.223]:23501 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id S261878AbTE2FVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:21:31 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Marc Wilson" <msw@cox.net>, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Date: Thu, 29 May 2003 06:34:48 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030529052425.GA1566@moonkingdom.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc.

 > I just had mutt > freeze cold on me though for ~15 sec when
 > it tried to open my debian-devel mbox (rather large file)
 > while brag was beating on the drive.
 >
 > <whimper>

I used to get the same effect when I asked pine to open the
Linux-Kernel mailbox on my system. I long since cured that by
having procmail split Linux-Kernel mail into multiple mailboxes,
one for each calendar week.

The basic problem there is that any mail client needs to know
just how many messages are in a particular folder to handle that
folder, and the only way to do this is to count them all. That's
what takes the time when one opens a large folder.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.484 / Virus Database: 282 - Release Date: 27-May-2003


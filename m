Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRLFUMl>; Thu, 6 Dec 2001 15:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284164AbRLFUMW>; Thu, 6 Dec 2001 15:12:22 -0500
Received: from [199.29.68.123] ([199.29.68.123]:19729 "EHLO MailAndNews.com")
	by vger.kernel.org with ESMTP id <S282670AbRLFUMN>;
	Thu, 6 Dec 2001 15:12:13 -0500
X-WM-Posted-At: MailAndNews.com; Thu, 6 Dec 01 15:12:07 -0500
Message-ID: <001701c17e92$4775c4f0$0500a8c0@myroom>
From: "Matt Schulkind" <mschulkind@mailandnews.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] GeForce3 support for rivafb
Date: Thu, 6 Dec 2001 15:12:06 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the original e-mail should have said 2.4.17-pre2 so it should have looked
like:

I basically just copied the source files from the xfree86 4.1.0 nv driver
and
then tweaked the rest of the rivafb files to get it to work. The patch is
against the 2.4.17-pre2 tree. I'd like anyone with a geforce3 card at their
disposal to please test this out and lemme know what you think.

-Matt Schulkind


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRAYUUm>; Thu, 25 Jan 2001 15:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbRAYUUc>; Thu, 25 Jan 2001 15:20:32 -0500
Received: from mail.myrealbox.com ([192.108.102.201]:64573 "EHLO myrealbox.com")
	by vger.kernel.org with ESMTP id <S129311AbRAYUUS>;
	Thu, 25 Jan 2001 15:20:18 -0500
Message-ID: <003401c0870c$3362e390$9b2f4189@angelw2k>
From: "Micah Gorrell" <angelcode@myrealbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: eepro100 problems in 2.4.0
Date: Thu, 25 Jan 2001 13:20:03 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have doing some testing with kernel 2.4 and I have had constant problems
with the eepro100 driver.  Under 2.2 it works perfectly but under 2.4 I am
unable to use more than one card in a server and when I do use one card I
get errors stating that eth0 reports no recources.  Has anyone else seen
this kind of problem?

Micah
___
The irony is that Bill Gates claims to be making a stable operating system
and Linus Torvalds claims to be trying to take over the world

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

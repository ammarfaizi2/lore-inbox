Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbTJASx4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTJASx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:53:56 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:5138 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S262057AbTJASxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:53:54 -0400
Reply-To: <mail@davehatton.it>
From: "Dave Hatton" <mail@davehatton.it>
To: <linux-kernel@vger.kernel.org>
Subject: Problem switching between mains and battery on a laptop since 2.5.57
Date: Wed, 1 Oct 2003 19:55:34 +0100
Message-ID: <NCBBJGBIBFKKILGAFKOBMECLECAA.mail@davehatton.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am having a problem with my Mitac M722 laptop.

When I pull the main cord whilst the machine is running, it continues to
operate for 1-3 secs on battery power and then hangs/locks solid.
After a reboot ... there's nothing obvious in the logs.

This problem does not occur on 2.4 (I've tried all the way up to
2.4.22-bk27) and does not happen <= 2.5.56.

I've had a look at the change log for 2.5.57 and through the patch for
obvious things ... but nothing stands out.

Can anybody help me with this / suggest a plan of attack to narrow the
problem down?

TIA

Daveh

(Please CC me at on answers as I'm not currently subscribed to the mailing
list)





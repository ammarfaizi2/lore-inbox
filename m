Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVLAV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVLAV5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVLAV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:57:45 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:61463 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932512AbVLAV5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:57:44 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: <linux-kernel@vger.kernel.org>
Subject: What does lspci -vv "DEVSEL=slow" and "DEVSEL=medium" mean?
Date: Thu, 1 Dec 2005 16:06:04 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcX2w2xGp6vGhFzlQcerfwT3XPJV7Q==
Message-ID: <EXCHG2003gStMVhEUse00000154@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 01 Dec 2005 21:52:09.0137 (UTC) FILETIME=[7A53F210:01C5F6C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have 30+ machines, one machine is slower on using an 
infiniband card than the than the others, 
everything we can find is the same except on the "lspci -vv" the
slow machine reports:

"DEVSEL=slow" 

And all of the rest report:

 "DEVSEL=medium"

Both machines have the same bus speed listed, but this is
known to be somewhat shakey on the driver it is using.

What exactly does this mean?

We know the bios version is the same and we believe the 
bios settings are the same, and that the card
is identical, and in the same slot, and that everything else
is the same. 

                       Roger


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTIWPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbTIWPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:17:28 -0400
Received: from www.wotug.org ([194.106.52.201]:60714 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S261344AbTIWPR1 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:17:27 -0400
From: "Ruth Ivimey-Cook" <Ruth.Ivimey-Cook@ivimey.org>
To: "Linux-Kernel" <Linux-Kernel@vger.kernel.org>
Subject: How are the Promise drivers doing?
Date: Tue, 23 Sep 2003 16:17:24 +0100
Message-ID: <001901c381e5$cb36b580$0500a8c0@Robinton>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-Spam-Score: -0.4 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I'm about to get a new motherboard or two for a large personal
fileserver with min 4 parallel 120G IDE disks using Linux RAID5. I am
trying to decide which MB and what additional components to use. Current
favorite is the MSI KT6-Ultra FISR, which uses a Broadcom chip for GigE
(good?) but with a Promise 20378 providing additional IDE (not sure).

These days it seems more motherboards that have additional IDE ports use
Promise chips, with a few using HPT ones. I note the advent of the
Promise GPL SATA drivers and Jeff's libata. I am also aware that my
current setup ( Linux 2.4.22 and onboard 20276) does occasionally cause
me grief, with lost interrupts making me wonder if all is well. I have 2
Promise 20267 IDE cards available should that be useful.

Should I steer clear of the Promise chips and use HPT ones (either MB,
or the RocketRAID, or Adaptec 1200 cards) or have folks got them licked
now?

Thanks for any help,

Ruth



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVIGJU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVIGJU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:20:27 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:31173 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751109AbVIGJU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:20:26 -0400
Date: Wed, 07 Sep 2005 11:20:24 +0200
Message-Id: <919041183@web.de>
MIME-Version: 1.0
From: Lars Ziegler <lziegler@web.de>
To: linux-kernel@vger.kernel.org
Subject: ACPI causes sata timeout errors
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo all,
I'm running kernel 2.6.13 on an Asus SK8N motherboard with an AMD 
Opteron. I use the onboard Promise Fasttrak 378 Raid Controller in RAID 
1 mode. Every time I turn off ACPI my machine hangs just some minutes 
after boot up. The kernel reports
sata timeout error
One solution to solve this problem is just to let the acpi turned on, 
but i suppose that the acpi causes scsi parity errors on my symbios uw 
scsi controller. And I really need the scsi controller to store my data 
on my tape. Has any body an idea what I can do to get both controllers run.
Thanks a lot
Lars

_________________________________________________________________________
Mit der Gruppen-SMS von WEB.DE FreeMail können Sie eine SMS an alle 
Freunde gleichzeitig schicken: http://freemail.web.de/features/?mc=021179




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbTI2LdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 07:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTI2LdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 07:33:08 -0400
Received: from [202.56.133.247] ([202.56.133.247]:44896 "EHLO
	mgdigital.mgdigital.com.sg") by vger.kernel.org with ESMTP
	id S263162AbTI2LdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 07:33:06 -0400
Message-Id: <6.0.0.22.0.20030929191802.025352f8@mail.mgdigital.com.sg>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Mon, 29 Sep 2003 19:32:56 +0800
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
From: Hong Feng <hongfeng@mgdigital.com.sg>
Subject: Sync problem with Ethernet-over-USB driver and Qtopia desktop
In-Reply-To: <20030929123949.A19506@infomag.infomag.iguana.be>
References: <20030917214836.A26822@infomag.infomag.iguana.be>
 <20030929123949.A19506@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-OriginalArrivalTime: 29 Sep 2003 11:33:03.0236 (UTC) FILETIME=[71A7C440:01C3867D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I met a very funny problem. I am writing the ethernet-over-usb driver for 
our PDA based on embedded Linux and QT/Qtopia. We use Qtopia desktop as the 
sync tools. Before our device launched the Qtopia-1.6.2. I can ping the 
device from my computer for a very long time. It looks that the connection 
is very stable. When Qtopia was launched, the connection will vanished in a 
short while, >3 seconds. How long the connection can last is not a constant 
value.  When I used Qtopia desktop to do the synchronization, it will 
failed 95%.

Who knows the problem, please give me some comments. BTW, the kernel 
version is 2.4.18. QT's version is 2.3.6. Qtopia's version is 1.6.2.

Regards

Hong Feng






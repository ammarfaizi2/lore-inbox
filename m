Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTIAVve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTIAVve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:51:34 -0400
Received: from 24-117-48-106.cpe.cableone.net ([24.117.48.106]:33668 "EHLO
	mail.grayserv.com") by vger.kernel.org with ESMTP id S262268AbTIAVvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:51:33 -0400
Subject: siimage 1.06 in kernel 2.6
From: JD Gray <kahdgarxi@grayserv.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062453091.2075.13.camel@mikhail.grayserv.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 14:51:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use an SiS SATA controller that uses the siimage driver
(drivers/ide/pci/siimage.c) I have an -ac 2.4 kernel that uses version
1.06 of this driver, and it works very well (~65MB/s). Kernel 2.6 on the
other hand has version 1.02 of this driver which gets very poor
preformance (~1.5MB/s.) I would like to know if anyone is working on
getting 1.06 into the 2.6 kernel. (I've tried several ways to get it
working including copying the .c straight from my kernel and patch
posted on this mailing list. Neither worked, it wouldn't compile either
time.) If no one is, then this is a request per say. If anyone has time
and/or is able to put this new driver into the 2.6 kernel I would be
greatly thankful. Thanks alot
-JD Gray
(KahdgarXI)


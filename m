Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275345AbTHITTP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275370AbTHITTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:19:15 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:34432 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S275345AbTHITSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:18:13 -0400
From: "Nicolas P." <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: ov511 2.6.0-test3 
Date: Sat, 9 Aug 2003 21:15:18 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308092115.18501.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is new to kernel 2.6.0-test3 :

*** Warning: "video_proc_entry" [drivers/usb/media/ov511.ko] undefined!

And documentation seems obsolete :

This driver uses the Video For Linux API. You must say Y or M to
"Video For Linux" (under Character Devices) to use this driver.
Information on this API and pointers to "v4l" programs may be found
on the WWW at <http://roadrunner.swansea.uk.linux.org/v4l.shtml>.


Not any more under Character Devices, isn't it ?

Regards.

Nicolas.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264622AbUEDVSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264622AbUEDVSl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUEDVRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 17:17:41 -0400
Received: from bay18-f8.bay18.hotmail.com ([65.54.187.58]:16907 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264623AbUEDVQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 17:16:46 -0400
X-Originating-IP: [67.22.169.122]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Promise 378 controller driver absent from Linux Kernel?
Date: Tue, 04 May 2004 21:16:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F8Hg2uUGdrXJS000000a3@hotmail.com>
X-OriginalArrivalTime: 04 May 2004 21:16:43.0189 (UTC) FILETIME=[193A0650:01C4321D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found a GPL'd patch for 2.4.23

http://www.uwsg.iu.edu/hypermail/linux/kernel/0307.2/2039.html

However, will this chipset ever be supported in the vanilla kernel source 
tree?

Does anyone have a Promise 378 controller using Serial ATA RAID 1 and able 
to boot from it successfully?

So far, google has yielded nothing but horror stories regarding getting this 
driver to work, some implementations use SCSI-transport to control the SATA 
controller, but this seems like a nightmare, is there a solution in the 
works?

_________________________________________________________________
MSN Toolbar provides one-click access to Hotmail from any Web page – FREE 
download! http://toolbar.msn.com/go/onm00200413ave/direct/01/


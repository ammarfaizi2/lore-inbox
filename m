Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135895AbRDTMjT>; Fri, 20 Apr 2001 08:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135897AbRDTMjJ>; Fri, 20 Apr 2001 08:39:09 -0400
Received: from [159.226.41.188] ([159.226.41.188]:54034 "EHLO
	gatekeeper.ncic.ac.cn") by vger.kernel.org with ESMTP
	id <S135895AbRDTMix>; Fri, 20 Apr 2001 08:38:53 -0400
Date: Fri, 20 Apr 2001 20:39:49 +0800
From: "Xiong Zhao" <xz@gatekeeper.ncic.ac.cn>
To: majordomo linux kernel list <linux-kernel@vger.kernel.org>
Subject: problem of partitioning
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-ID: <77457A5BAFA.AAA2872@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,all.after i create a new logical partition using fdisk or cfdisk
and exit with "w",there always comes report saying that re-read table 
failed with error 16:device or resource busy.next time i attempt to mount
the newly created partition it comes error:mount /dev/sdx has wrong major
or minor number.the same thing happens after i reboot the machine.can
anyone give me a hand.

thanks in advance.


james


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266269AbTGEC6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 22:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbTGEC6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 22:58:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:56729 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266269AbTGEC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 22:58:52 -0400
Date: Fri, 4 Jul 2003 23:13:11 -0400
From: Brandon Penglase <linux-kernel1@SpaceServices.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic on boot since 2.5.70
Message-Id: <20030704231311.603f79d8.linux-kernel1@SpaceServices.net>
Organization: space Networks
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I've been using 2.5.x since about .58 or so, never had any problems. Last I had .69, and I tried to upgrade to 2.5.72 for some new options (got a sharp zaurus). When I tried it, I got this error:

[snip]
BIOS EDD Facility V0.09 2003-Jan-22, 1 device found
VFS: Cannot open root device "sda3" or sda3
Please append a correct "root=" boot option
Kenrel Panic: VFS: Unable to mount root FS on sda3

I've been using for over 3 years now, never had a problem with this. I have a Adaptec 2940 Ultra2 SCSI adapter (OEM), I compiled the currect "module" into the kernel, just like I always have. When 2.5.72 wouldn't work, I went back and tried each one to .70, and non worked. Not even the lastest .74 works. I have changed nothing in my config file besides the USB network, which I have tried with and without, showing the same errors.

Any help on this would be great!
    Brandon Penglase


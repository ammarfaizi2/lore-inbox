Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUDJNTW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 09:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDJNTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 09:19:22 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:37723 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S262014AbUDJNTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 09:19:21 -0400
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
Organization: adaptive planet
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm3 : get module oops when booting with inserted usb devices
Date: Sat, 10 Apr 2004 15:19:20 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404101519.20456.wim.delvaux@adaptiveplanet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I get an oops when I boot my kernel with usbdevices plugged in.
If I unplug them the booting continues and I can insert and remove them and 
make them work

Devices are : USB Bluetooth dongle and PEN Flash drive

Cannot show EXACT backtrace because it scrolls of the screen and cannot find 
any logging after reboot.  I do see usb_storage in the backtrace.

How Can I send you the complete backtrace ? 

W

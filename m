Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266651AbUBLWKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUBLWKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:10:10 -0500
Received: from web10410.mail.yahoo.com ([216.136.128.123]:35710 "HELO
	web10410.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266651AbUBLWJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:09:41 -0500
Message-ID: <20040212220938.66821.qmail@web10410.mail.yahoo.com>
Date: Fri, 13 Feb 2004 09:09:38 +1100 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.6 kernel, usb-storage and ps2 mouse problem
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-77197433-1076623778=:65397"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-77197433-1076623778=:65397
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

I got a box (details in the attached dmesg output), if
I plug the usb-storage (use usb 1.X) at the beginning
and boot kernel 2.6.X the box boot up and runing as
normal but run startx the mouse doesn't move. On the
contrary if I boot the box without the usb-storage
plugged in, everything works as normal, then plug the
usb disk, the disk also works as normal. (plug and
detach etc..).
There is no strange messages at all in the log file,
dmesg , etc.. .. The mouse is scroll optical mouse use
IMPS/2 protocol and attched to PS2 mouse port, 

The problem doesn't appear in 2.4 kernel, at least
2.4.23-rc1 I got it here.

If more information is needed to debug it pls cc me.

Regards,

=====
S.KIEU

http://greetings.yahoo.com.au - Yahoo! Greetings
Send your love online with Yahoo! Greetings - FREE!
--0-77197433-1076623778=:65397
Content-Type: application/gzip; name="dmesg.log.gz"
Content-Transfer-Encoding: base64
Content-Description: dmesg.log.gz
Content-Disposition: attachment; filename="dmesg.log.gz"

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
QNQ6V/5znKeO833Phvbq/1jc/wDqvBDnYCYAAA==

--0-77197433-1076623778=:65397--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbSLLVoj>; Thu, 12 Dec 2002 16:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267525AbSLLVoi>; Thu, 12 Dec 2002 16:44:38 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:14806 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267524AbSLLVoh> convert rfc822-to-8bit; Thu, 12 Dec 2002 16:44:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: More progress on loading 2.5.50
Date: Thu, 12 Dec 2002 13:51:50 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212121351.50151.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PSAUX is not some fantastic French technology, it must be enabled.

My 3COM/USB adapter seems to be enabled correctly but the LCD lights do not 
blink. Still testing.

95% there, although I did hack into do_mounts and force fed the proper root 
device.

The patch for make that fixes make modules works fine, thank you.


Question:  Can I turn REISERFS on and off for testing (does in nun on top of 
EXT2)

Yast is a dog.

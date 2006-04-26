Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWDZCkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWDZCkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDZCkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:40:16 -0400
Received: from frodo.csolve.net ([207.164.81.3]:27913 "EHLO frodo.csolve.net")
	by vger.kernel.org with ESMTP id S1751016AbWDZCkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:40:14 -0400
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6.16] hid-core.c error filling dmesg
Date: Tue, 25 Apr 2006 22:40:11 -0400
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252240.11915.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got the "Das Keyboard" USB keyboard, and I've found  a message filling 
up my logs:

drivers/usb/input/hid-core.c: input irq status -71 received

lsusb reports the keyboard as:
Bus 002 Device 002: ID 03f9:0100 KeyTronic Corp.

I've searched the list and seen some previous posts with similar errors, but 
no definitive answer, does anyone know how to fix this? Thanks!

-- 
Gabriel A. Devenyi
ace@staticwave.ca

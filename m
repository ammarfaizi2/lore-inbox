Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTGVBGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbTGVBGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:06:38 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59019 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261773AbTGVBGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:06:37 -0400
Date: Mon, 21 Jul 2003 21:21:37 -0400
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: hid: ctrl urb status -75?
Message-ID: <20030722012137.GA7159@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
X-Delivery-Agent: TMDA/0.75 (Ponder)
X-Primary-Address: mharrell@bittwiddlers.com
Reply-To: Matthew Harrell 
	  <mharrell-dated-1059268898.4dcd80@bittwiddlers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What does this error mean?  I'm attempting to plug in a USB keyboard I've got
and it gives me the messages

  hub 1-0:0: new USB device on port 1, assigned address 3
  input: USB HID v1.10 Keyboard [CHESEN USB Keyboard] on usb-0000:00:11.2-1
  drivers/usb/input/hid-core.c: ctrl urb status -75 received

Other USB keyboards work fine so it must be something special with this one.
This is under all kernels from 2.5.60 to 2.6.0-test1

-- 
  Matthew Harrell                          The Earth is like a tiny grain of
  Bit Twiddlers, Inc.                       sand, only much, much heavier.
  mharrell@bittwiddlers.com     

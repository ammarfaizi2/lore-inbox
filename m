Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbULTIpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbULTIpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbULTIo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:44:59 -0500
Received: from illchn-static-203.199.197.226.vsnl.net.in ([203.199.197.226]:8206
	"EHLO md3.vsnl.net.in") by vger.kernel.org with ESMTP
	id S261206AbULTIof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:44:35 -0500
Message-ID: <003001c4e670$3f5ef590$1600a8c0@sdsaravanan>
Reply-To: "V.Meenatchi Sundaram" <vms@qmaxtech.com>
From: "V.Meenatchi Sundaram" <vms@qmaxtech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Send me the solution for the error "USB disconnect on device 00:1d.7-7 address 3
Date: Mon, 20 Dec 2004 14:15:24 +0530
Organization: Qmax Test Equipments Pvt. Ltd.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
  We have wriiten  driver program for usb interface card which was
manufactured
by our company.In the driver, First  downloaded  the firmware
supplied by Cypress Inc.This firmware implements a vendor specific
command that will allow  to download the firmware to external RAM. At the
time of
downloading  the firmware for the ez-usb chip(in probe fn).
The following Error has occured from the dmesg.


"yes!!!!registered
USB device now attached to USBSample------->0
usbsample: probe succeeded
usb.c: USB disconnect on device 00:1d.7-7 address 2
enter in to disconnect
hub.c: new USB device 00:1d.7-7, assigned address 3
usb.c: USB device 3 (vend/prod 0x4832/0x8003) is not claimed by any active
drive
r.
usb.c: USB disconnect on device 00:1d.7-7 address 3   "


That is the message has given "the USB disconnect on device" error.
Send me the solution

          Regards
V.Meenatchi Sundaram,


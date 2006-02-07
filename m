Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWBGAPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWBGAPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWBGAPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:15:18 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:46140 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932295AbWBGAPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:15:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-archive:mime-version:content-type:sender;
        b=dnEin4VmabqkAH8xKYXOJL5OhygRVOozjF6smcRVxcyte3sfps2nJrL60JFfVwotOWKGATHfuRwKteeUfRsIVRfYjAmpGetaY1oLoSw6E/LQ+PEplFjeh2DWcX3iiq3qPKHIb4DBIA2Mvdrq+wIL1KwtwzfX7/VvTRZoshgciXQ=
Date: Mon, 6 Feb 2006 22:15:11 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: What causes "USB disconnect" ?
Message-ID: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never got this messages since I started using 2.6. Today I 
got it in 2.6.16-rc2. Is this a problem in this version ? How 
to determine ? I wasn't using the device.

Feb  6 20:49:48 pervalidus kernel: usb 1-2: USB disconnect, address 4
Feb  6 21:01:03 pervalidus kernel: usb 1-2: new low speed USB device using uhci_hcd and address 5
Feb  6 21:01:03 pervalidus kernel: usb 1-2: configuration #1 chosen from 1 choice
Feb  6 21:01:13 pervalidus kernel: /usr/local/src/kernel/linux-2.6.16/drivers/usb/input/hid-core.c: timeout initializing reports
Feb  6 21:01:13 pervalidus kernel: input: Logitech Inc. WingMan RumblePad as /class/input/input4
Feb  6 21:01:13 pervalidus kernel: input: USB HID v1.10 Joystick [Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2

-- 
How to contact me - http://www.pervalidus.net/contact.html

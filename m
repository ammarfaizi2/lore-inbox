Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRKPQVA>; Fri, 16 Nov 2001 11:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281457AbRKPQUt>; Fri, 16 Nov 2001 11:20:49 -0500
Received: from ns.xdr.com ([209.48.37.1]:53386 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S281410AbRKPQUl>;
	Fri, 16 Nov 2001 11:20:41 -0500
Date: Fri, 16 Nov 2001 08:20:33 -0800
From: Dave Ashley (linux mailing list) <linux@xdr.com>
Message-Id: <200111161620.fAGGKXu13997@xdr.com>
To: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] HP C618 digital camera drivers/usb/dc2xx.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the following line to the camera_table[] in drivers/usb/dc2xx.c to
add support for the HP Photosmart C618 camera.
	{ USB_DEVICE(0x03f0, 0x4102) },		// HP PhotoSmart C618

-Dave

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVA2DzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVA2DzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVA2DzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 22:55:19 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:28546 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261429AbVA2DzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 22:55:16 -0500
Subject: HID warning messages fills the logs
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 29 Jan 2005 04:55:06 +0100
Message-Id: <1106970906.10735.7.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when running 2.6.11-rc2-bk6 with my USB HID v1.00 Mouse [Microsoft
Microsoft Wheel Mouse Optical®] the logs get filled with this message:

kernel: drivers/usb/input/hid-input.c: event field not found
last message repeated 459 times
last message repeated 1157 times

Regards

Marcel



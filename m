Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318433AbSGSDb0>; Thu, 18 Jul 2002 23:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318434AbSGSDb0>; Thu, 18 Jul 2002 23:31:26 -0400
Received: from dsl-65-189-106-249.telocity.com ([65.189.106.249]:51083 "EHLO
	mail.temp123.org") by vger.kernel.org with ESMTP id <S318433AbSGSDb0>;
	Thu, 18 Jul 2002 23:31:26 -0400
Date: Thu, 18 Jul 2002 23:34:18 -0400
From: Josh Litherland <fauxpas@temp123.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB Keypad]
Message-ID: <20020719033418.GA23049@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 08:24:45PM -0700, Greg KH wrote:

> If the device is detected, how is it detected?  Is the USB HID driver
> binding to the device?

hub.c: USB new device connect on bus1/1, assigned device number 4
input0: USB HID v1.00 Keyboard [        USB Keypad                    ] on usb1:4.0

-- 
Josh Litherland (fauxpas@temp123.org)
public key: temp123.org/fauxpas.pgp
fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVERVCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVERVCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVERVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:02:13 -0400
Received: from smtp2.KPNQwest.pt ([193.126.4.60]:43221 "EHLO smtp.KPNQwest.pt")
	by vger.kernel.org with ESMTP id S262368AbVERVCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:02:04 -0400
Message-ID: <428BAD49.2040509@prozone.ws>
Date: Wed, 18 May 2005 22:02:01 +0100
From: David Oliveira <d.oliveira@prozone.ws>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Kroah-Hartman <linux-kernel@vger.kernel.org>
Subject: Stealing usb devices
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I saw your name on usb.c and thought you could help me. I wrote a simple
USB driver based on Vojtech Pavlik usbmouse.c for Logitech Mediaplay
Mouse (mouse with multimedia buttons) but I have a "compatibility"
problem annoying me. When hid or usbmouse ar running on the kernel, they
steal all mouse devices and my driver couldn't get it to give the
propper support for this specific device. There is a way of stealing
this device to handle it better than generic drivers?

Thank you for this time that I belive it's precious for you.
Regargs

David Oliveira
<d.oliveira@prozone.ws>


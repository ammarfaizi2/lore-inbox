Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264822AbUFOOHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264822AbUFOOHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUFOOHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:07:08 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:45696 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S264822AbUFOOHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:07:06 -0400
Date: Tue, 15 Jun 2004 14:07:05 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Cc: Lubomir Prech <Lubomir.Prech@mff.cuni.cz>
Subject: CONFIG_USB_HID vs. CONFIG_USB_HIDINPUT
Message-ID: <20040615140705.B6153@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I enable CONFIG_USB_HID and not enable CONFIG_USB_HIDINPUT in 2.4.25, will
I get something different from when I don't enable neither of them?

The <Help> says basically the same about both: that they control
"keyboards, mice, joysticks, graphics tablets, or any other HID based devices"
(CONFIG_USB_HID)
"keyboard, mouse or joystick or any other HID input device"
(CONFIG_USB_HIDINPUT)

I assume
1) it doesn't matter if "keyboard" or "keyboards" is in the <Help>
2) graphics tablets are assumed to be "any other HID input devices".

Cl< 

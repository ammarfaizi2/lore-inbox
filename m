Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUH1Tid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUH1Tid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267660AbUH1Tid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:38:33 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:15503 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267653AbUH1Tib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:38:31 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Logitech optical usb mouse and vfat partition passing from 2.6.7 to 2.6.8.1 kernel
Date: Sat, 28 Aug 2004 14:38:26 -0500
User-Agent: KMail/1.6.2
Cc: Al <wizard@slacky.it>
References: <200408281704.27031.wizard@slacky.it>
In-Reply-To: <200408281704.27031.wizard@slacky.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408281438.26599.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 August 2004 10:04 am, Al wrote:
> 
> And this is the .config file of kernel 2.6.8.1 followed from the dmesg: 
> 
> [...]
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_INPORT is not set
> # CONFIG_MOUSE_LOGIBM is not set
> # CONFIG_MOUSE_PC110PAD is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> CONFIG_INPUT_UINPUT=y
> [...]
> 

Do you have USB HID compiled/installed?

-- 
Dmitry

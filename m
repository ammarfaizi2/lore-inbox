Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSJVJLe>; Tue, 22 Oct 2002 05:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSJVJLe>; Tue, 22 Oct 2002 05:11:34 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:1745 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261874AbSJVJLd>; Tue, 22 Oct 2002 05:11:33 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Take Vos <Take.Vos@binary-magic.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: USB mouse does not apear in /dev/input
Date: Tue, 22 Oct 2002 19:09:10 +1000
User-Agent: KMail/1.4.5
References: <200210221046.46700.Take.Vos@binary-magic.com>
In-Reply-To: <200210221046.46700.Take.Vos@binary-magic.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221909.10753.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 22 Oct 2002 18:46, Take Vos wrote:
> Hello,
>
> I'm just doing my part in getting the new kernel stable
Functional would help too!

> kernel:	linux-2.5.43
> hardware:DELL Inspiron 8100
> mouse:	Logitech USB Optical Mouse
> config:
> 		CONFIG_INPUT_MOUSEDEV
> 		CONFIG_INPUT_EVDEV
> 		CONFIG_SERIO
> 		CONFIG_SERIO_I8042
> 		CONFIG_INPUT_MOUSE
> 		CONFIG_MOUSE_PS2
> 		CONFIG_USB
> 		CONFIG_USB_HID
> 		CONFIG_USB_HIDINPUT
Can you show us /proc/bus/usb/devices?
And also /proc/bus/input/devices?

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9tRW2W6pHgIdAuOMRAtj2AKCIo9LTjXJBFzy1+4d4ogxT1yhy3gCfesLQ
DNbsvFVxrZKt+3PfNZcK94g=
=eOQd
-----END PGP SIGNATURE-----


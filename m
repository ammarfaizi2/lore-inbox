Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268755AbTBZRpg>; Wed, 26 Feb 2003 12:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268833AbTBZRpg>; Wed, 26 Feb 2003 12:45:36 -0500
Received: from [129.46.51.58] ([129.46.51.58]:19613 "EHLO numenor.qualcomm.com")
	by vger.kernel.org with ESMTP id <S268755AbTBZRpf>;
	Wed, 26 Feb 2003 12:45:35 -0500
Message-Id: <5.1.0.14.2.20030226094432.0212c910@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 26 Feb 2003 09:47:42 -0800
To: "Balarama Krishna Yalavarthi" <balaram@linuxmail.org>,
       linux-kernel@vger.kernel.org
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: Linux Kernel- Bluetooth HID Keyboard support?????
In-Reply-To: <20030226095658.21932.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:56 AM 2/26/2003, Balarama Krishna Yalavarthi wrote:
>Hi Folks,
>        I am implementing Bluetooth HID profile for Keyboards. Inorder to test it I need a host device (PC).
>        I wonder if the Latest Linux Kernel supports Bluetooth HID Keyboard. 
>        A mini driver, which talks to HID Class Driver and Bluetooth Protocol stack(L2CAP to Baseband), 
>          is required on the Host side
>        Please let me know the supported linux kernel version and files related to that.
Currently we don't have kernel Bluetooth HID support.
We do have user-space tools that support some Bluetooth keyboards though.
Why don't join bluez-devel@lists.sf.net mailing list and we'll discuss it there.

Max


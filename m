Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266489AbSKORaP>; Fri, 15 Nov 2002 12:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSKORaP>; Fri, 15 Nov 2002 12:30:15 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:9668 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S266489AbSKORaO>; Fri, 15 Nov 2002 12:30:14 -0500
Message-Id: <5.1.0.14.2.20021115093541.138d55e0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 15 Nov 2002 09:37:03 -0800
To: Joyce Tan <blutot@yahoo.com>,
       kernel mailing list <linux-kernel@vger.kernel.org>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: bug in hci_usb (bluetooth usb driver) in linux-2.5.47?
In-Reply-To: <20021115054901.2435.qmail@web41005.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:49 PM 11/14/2002 -0800, Joyce Tan wrote:
>Hi,
>
>I tried testing linux-2.5.47 with builtin bluetooth
>support with ohci.
>I get this error when I do "hciconfig".
>
>root@Javelina kernel]$hciconfig hci0 up
>hci_usb_send_ctrl: hci0 ctrl tx submit failed urb c6bd76e0 err -90

You forgot to mention what kind of Bluetooth device is that.
btw This soft of question belong to bluez-users@lists.sf.net.

Max


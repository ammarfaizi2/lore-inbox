Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbRBCByo>; Fri, 2 Feb 2001 20:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBCBye>; Fri, 2 Feb 2001 20:54:34 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:61284 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129130AbRBCBy0>; Fri, 2 Feb 2001 20:54:26 -0500
Message-ID: <3A7B64C8.3ADD47B1@linux.com>
Date: Fri, 02 Feb 2001 17:54:17 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mirabilos <eccesys@topmail.de>
CC: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1 - can't read root fs (devfs maybe?)
In-Reply-To: <Pine.LNX.4.21.0101312258190.227-100000@sliver.moot.ca> <3A79F812.D52B17B1@linux.com> <022901c08d1f$bf8a2c20$0100a8c0@homeip.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> image=/boot/bzImage
>  label=linux
>  append="root=/dev/ide/host0/bus0/target0/lun0/part1 vga=3845"

root=/dev/ide/host.... will work the same as root=/dev/hda... in pre-devfs

-d

--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

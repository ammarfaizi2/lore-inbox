Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266100AbSKWATE>; Fri, 22 Nov 2002 19:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbSKWATE>; Fri, 22 Nov 2002 19:19:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:28617 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266100AbSKWATD>; Fri, 22 Nov 2002 19:19:03 -0500
Message-ID: <000c01c29286$ea808780$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "SLion" <s.lion@verizon.net>, <linux-kernel@vger.kernel.org>
References: <20021123000823.GA11439@ingchai.lan>
Subject: Re: 2.5.49 bk 
Date: Fri, 22 Nov 2002 16:26:07 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got drivers/char/watchdog/Kconfig in my pull

Are you sure you don't need to bk get the file?

    -rustyl
----- Original Message -----
From: "SLion" <s.lion@verizon.net>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, November 22, 2002 4:08 PM
Subject: 2.5.49 bk


> Just pulled 2.5.49 and get the following while doing menuconfig.
>
>   gcc  -o scripts/lxdialog/lxdialog scripts/lxdialog/checklist.o
>   scripts/lxdialog/menubox.o scripts/lxdialog/textbox.o
>   scripts/lxdialog/yesno.o scripts/lxdialog/inputbox.o
>   scripts/lxdialog/util.o scripts/lxdialog/lxdialog.o
>   scripts/lxdialog/msgbox.o -lncurses
>   ./scripts/kconfig/mconf arch/i386/Kconfig
>   drivers/char/Kconfig:640: can't open file
>   "drivers/char/watchdog/Kconfig"
>   make: *** [menuconfig] Error 1
>
> Looks like something got lost here.
>
> -SL
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


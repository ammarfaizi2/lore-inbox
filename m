Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130310AbQKGDPm>; Mon, 6 Nov 2000 22:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129716AbQKGDPd>; Mon, 6 Nov 2000 22:15:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12042 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129694AbQKGDPV>;
	Mon, 6 Nov 2000 22:15:21 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.4.0-test9 
In-Reply-To: Your message of "Mon, 06 Nov 2000 16:31:23 CDT."
             <Pine.LNX.3.95.1001106162033.212A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Nov 2000 14:15:14 +1100
Message-ID: <9703.973566914@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000 16:31:23 -0500 (EST), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>However when running, the new kernel 2.4.0-test9, can't be used to
>make a usable initrd ram disk. The result being that 2.4.0-test9
>can't, itself, build an "initrd" bootable system.
>
>Before everybody screams that I don't know what I'm doing, let me
>assure you that I know that the two kernels put their modules in
>different directories and the new directory scheme seems to require
>the latest and greatest version of modutils.

You also need the latest version of mkinitrd to handle the modules
directory structure.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

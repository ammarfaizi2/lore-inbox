Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJ2JjJ>; Tue, 29 Oct 2002 04:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261729AbSJ2JjJ>; Tue, 29 Oct 2002 04:39:09 -0500
Received: from mail14.bigmailbox.com ([209.132.220.45]:44770 "EHLO
	mail14.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S261728AbSJ2JjI>; Tue, 29 Oct 2002 04:39:08 -0500
Date: Tue, 29 Oct 2002 01:45:25 -0800
Message-Id: <200210290945.g9T9jP619257@mail14.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [218.2.150.97]
From: "Jim Zeus" <jimzeus@edguy.nu>
To: linux-kernel@vger.kernel.org
Subject: Some Question about tty
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,folks

I am reading the source code about tty(tty_io.c,n_tty.c,tty_ioctl.c etc)to implement some virtual tty which link to the UART through complex protocol .

My problem:
I know /dev/tty is the current terminal,
and /dev/ttySX is serial port,
but what is /dev/tty0,/dev/ttyX,/dev/console,/dev/cuaX,/dev/cuaX?
I got confused with these.

what is /dev/ptmx?what is ptm/pts? what is the device which's major device number is 128-135 and 136-143,what is the relationship among them?

I am sorry about my poor Englist and maybe foolish question,but I really need help.

TIA

BTW:can somebody show me any link to Mailing list/News group/Forum which about tty?



------------------------------------------------------------
Edguy's Official Website - http://www.edguy.nu


---------------------------------------------------------------------
Express yourself with a super cool email address from BigMailBox.com.
Hundreds of choices. It's free!
http://www.bigmailbox.com
---------------------------------------------------------------------

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSGDPNO>; Thu, 4 Jul 2002 11:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSGDPNN>; Thu, 4 Jul 2002 11:13:13 -0400
Received: from 205-158-62-54.outblaze.com ([205.158.62.54]:20749 "HELO
	ws1-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317429AbSGDPNM>; Thu, 4 Jul 2002 11:13:12 -0400
Message-ID: <20020704151450.75171.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lee Chin" <leechin@mail.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2002 10:14:50 -0500
Subject: writing to serial console
X-Originating-Ip: 24.229.6.172
X-Originating-Server: ws1-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to write status messages to the serial console as the kernel boots up.  I tried writing to ttyS0 in main.c, but the kernel crashes with a paging violation.  Is there an easy way to do this?

Thanks
Lee
-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Save up to $160 by signing up for NetZero Platinum Internet service.
http://www.netzero.net/?refcd=N2P0602NEP8


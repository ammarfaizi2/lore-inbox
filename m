Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264751AbSJUGtz>; Mon, 21 Oct 2002 02:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJUGtz>; Mon, 21 Oct 2002 02:49:55 -0400
Received: from web12806.mail.yahoo.com ([216.136.174.41]:34396 "HELO
	web12806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264751AbSJUGty>; Mon, 21 Oct 2002 02:49:54 -0400
Message-ID: <20021021065600.3738.qmail@web12806.mail.yahoo.com>
Date: Sun, 20 Oct 2002 23:56:00 -0700 (PDT)
From: Latha B lingaiah <l_lingaiah@yahoo.com>
Subject: TCP  DELAY
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While transfering a 42MB file, there seem to be a TCP
delay between the kernels 2.4.7 and 2.4.18.

Here are some data :-

In 2.4.7 kernel :

43843584B in 4.486s = 9.77342e+06B/s = 9544.36KB/s =
9.32066MB/s

In 2.4.18 kernel :
 43843584B in 3.711s = 1.18145e+07B/s = 11537.6KB/s =
11.2672MB/s

I am looking at the reason behind the delay in 2.4.7
kernel. Any comments on this?



PS: Please CC me with reply, as i am not subscribed to
the list.

thanks,
latha

__________________________________________________
Do you Yahoo!?
Y! Web Hosting - Let the expert host your web site
http://webhosting.yahoo.com/

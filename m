Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265788AbRFXXSV>; Sun, 24 Jun 2001 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbRFXXSL>; Sun, 24 Jun 2001 19:18:11 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:20234 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265788AbRFXXSG>;
	Sun, 24 Jun 2001 19:18:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "John Nilsson" <pzycrow@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some experience of linux on a Laptop 
In-Reply-To: Your message of "Sun, 24 Jun 2001 22:51:56 +0200."
             <F175UFyfL1QMaCAP6Ki00001f92@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 09:17:58 +1000
Message-ID: <23815.993424678@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jun 2001 22:51:56 +0200, 
"John Nilsson" <pzycrow@hotmail.com> wrote:
>1: Make the whole insmod-rmmod tingie a kernel internal so they could be 
>trigged before rootmount.

initrd.

>2: Compile time optimization options in Make menuconfig

Select the processor type.

>3: Lilo/grub config in make menuconfig

Will be in the 2.5 makefile rewrite.

>4: make bzImage && make modules && make modules install && cp 
>arch/i386/boot/bzImage /boot/'uname -r' something inside make menuconfig

Will be in the 2.5 makefile rewrite.


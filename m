Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRGHIYG>; Sun, 8 Jul 2001 04:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbRGHIX4>; Sun, 8 Jul 2001 04:23:56 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:43013 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266469AbRGHIXq>;
	Sun, 8 Jul 2001 04:23:46 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbols in 2.4.6 
In-Reply-To: Your message of "Sun, 08 Jul 2001 02:46:46 EST."
             <004e01c10782$250c71c0$66b93604@molybdenum> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Jul 2001 18:23:40 +1000
Message-ID: <22800.994580620@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 02:46:46 -0500, 
"Jahn Veach - Veachian64" <V64@Galaxy42.com> wrote:
>The output of depmod -e -a 2.4.6 can be found at
>http://galaxy42.com/data/moderr.txt.

What does 'grep printk /proc/ksyms' report on the 2.4.6 kernel?  Also
'nm vmlinux | grep printk' against the vmlinux for your 2.4.6 kernel?


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132884AbRDEM5t>; Thu, 5 Apr 2001 08:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132885AbRDEM5i>; Thu, 5 Apr 2001 08:57:38 -0400
Received: from ns2.servicenet.com.ar ([200.41.148.12]:61970 "EHLO
	servnet.servicenet.com.ar") by vger.kernel.org with ESMTP
	id <S132884AbRDEM5e>; Thu, 5 Apr 2001 08:57:34 -0400
Message-ID: <A0C675E9DC2CD411A5870040053AEBA0284170@MAINSERVER>
From: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: asm/unistd.h
Date: Thu, 5 Apr 2001 09:58:43 -0300 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1461.28)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm taking a look at the linux code and I don't understand how do you
programm...mmm (?) may be i'm a stupid why in include/asm/unistd.h in some
macros you use this:

do {
...
} while (0)

Thanks in advance.

Eliel C. Sardanons

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263656AbRFCREc>; Sun, 3 Jun 2001 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRFCQhT>; Sun, 3 Jun 2001 12:37:19 -0400
Received: from mnh-1-09.mv.com ([207.22.10.41]:6405 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263106AbRFCQVA>;
	Sun, 3 Jun 2001 12:21:00 -0400
Message-Id: <200106031732.MAA01631@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What is i386 thread.trapno? 
In-Reply-To: Your message of "Sun, 03 Jun 2001 12:16:09 +0100."
             <E156Vrd-0004Cq-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Jun 2001 12:32:50 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk said:
> include/asm-i386/siginfo.h 

Using SA_INFO would be nice, but it doesn't look like the siginfo will tell me 
whether the faulting operation is a read or write.

				Jeff



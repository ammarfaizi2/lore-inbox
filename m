Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130047AbRBUCrh>; Tue, 20 Feb 2001 21:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130115AbRBUCr1>; Tue, 20 Feb 2001 21:47:27 -0500
Received: from [210.77.38.126] ([210.77.38.126]:64516 "EHLO
	ns.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S130047AbRBUCrS>; Tue, 20 Feb 2001 21:47:18 -0500
Date: Wed, 21 Feb 2001 10:44:30 +0800
From: michaelc <michaelc@turbolinux.com.cn>
X-Mailer: The Bat! (v1.48) UNREG / CD5BF9353B3B7091
Reply-To: michaelc <michaelc@turbolinux.com.cn>
X-Priority: 3 (Normal)
Message-ID: <544126968.20010221104430@turbolinux.com.cn>
To: linux-kernel@vger.kernel.org
Subject: can somebody explain how linux support 64G memory
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   How does linux support more than 4G memory? I 've read the
   documentation of  Intel IA-32 Architecture, I knew that OS
   just address up to 4G physical address space, If OS want to
   access additional 4-GByte section of physical memory, it must
   change the pointer in register CR3 or entries in the
   page-directory-pointer table. That means that Linux just has
   up to 4-GByte page mapping at one time , is that right?

  

-- 
Best regards,
 michael chen                          mailto:michaelc@turbolinux.com.cn



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317720AbSGPBGx>; Mon, 15 Jul 2002 21:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317721AbSGPBGw>; Mon, 15 Jul 2002 21:06:52 -0400
Received: from [203.24.179.114] ([203.24.179.114]:4874 "HELO aimedics.com")
	by vger.kernel.org with SMTP id <S317720AbSGPBGv> convert rfc822-to-8bit;
	Mon, 15 Jul 2002 21:06:51 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: nejhdeh <nejhdeh@aimedics.com>
Organization: AiMedics Pty. Ltd.
To: linux-kernel@vger.kernel.org
Subject: Basic question
Date: Tue, 16 Jul 2002 11:08:39 +1000
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207161108.39689.nejhdeh@aimedics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I end up getting all the required source codes from kernel-source-2.4.18-5.RPM
> 

> Now, it appears for me to use the kernel routines such as enable_irq 
(defined 
> in (/usr/src/linux-2.4.18-5/arch/i386/kernel/irq.c) I have to make the 
entire 
> kernel.o, since there are a lot of dependencies.
> 

> Do I need to go this far?? 
> 

> What is a simpler way to use these routines (in irq.c) with my application??
> 

> How do I link this module (i.e irq.o) with my application?? I get heaps of 
> unresoleved errors.


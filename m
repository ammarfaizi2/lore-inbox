Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130429AbRAaUlA>; Wed, 31 Jan 2001 15:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbRAaUku>; Wed, 31 Jan 2001 15:40:50 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:62712 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130429AbRAaUko>; Wed, 31 Jan 2001 15:40:44 -0500
Date: Wed, 31 Jan 2001 14:40:41 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <009701c08bc2$573aee10$7253e59b@megatrends.com>
In-Reply-To: <20010131195434.29410.qmail@web8002.mail.in.yahoo.com>
Subject: Re: A query regarding kernel programming, very small
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-ID: <hxkv1B.A.WeC.JhHe6@dinero.interactivesi.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from "Venkatesh Ramamurthy" <venkateshr@softhome.net> on
Wed, 31 Jan 2001 15:13:38 -0500


> driver development is a part of kernel development. Kernel is a bigger
> entity which contains scheduler, io subsystem, memory subsystem etc....
> Drivers comes under the IO subsystem.

I think the confusion stems from the fact that with some operating systems
(like OS/2), drivers are not considered part of the kernel, but with Linux (and
possibly some others), drivers are considered part of the kernel.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

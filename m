Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265593AbRF1H5E>; Thu, 28 Jun 2001 03:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265599AbRF1H4y>; Thu, 28 Jun 2001 03:56:54 -0400
Received: from t111.niisi.ras.ru ([193.232.173.111]:40480 "EHLO
	t111.niisi.ras.ru") by vger.kernel.org with ESMTP
	id <S265593AbRF1H4i>; Thu, 28 Jun 2001 03:56:38 -0400
Message-ID: <3B3B5349.3050905@niisi.msk.ru>
Date: Thu, 28 Jun 2001 11:54:49 -0400
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Barry Wu <wqb123@yahoo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: about linux mips ext2fs
In-Reply-To: <20010625155706.66345.qmail@web13907.mail.yahoo.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry Wu wrote:

>
>I want port linux to our mipsel system. The kernel
>can work and system stop at mount root file system.
>I download root file system for mipsel from MIPS
>company. Because our system have no ethernet
>interface,
>I have to copy root file system directly to our hard
>disk. I put hard disk under intel linux, and using 
>fdisk and make ex2fs on it. Then I copy root file 
>system to hard disk. After finished, I place this hard
>disk under our mipsel environment. I do not know if 
>it can work under this environment, the kernel can
>mount root file system? If someone knows, please help
>me.
>
I have MIPSEB, and there is no problems with ext2. As i know, it doesn't 
matter
where you created your rootfs and put it on disk. But you have to take the
kernel for a MIPS from oss.sgi.com, by the way.


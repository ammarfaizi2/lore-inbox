Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbSJBOes>; Wed, 2 Oct 2002 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263161AbSJBOes>; Wed, 2 Oct 2002 10:34:48 -0400
Received: from [213.226.134.105] ([213.226.134.105]:19230 "EHLO mx.ktv.lt")
	by vger.kernel.org with ESMTP id <S263160AbSJBOer>;
	Wed, 2 Oct 2002 10:34:47 -0400
Date: Wed, 2 Oct 2002 16:39:58 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: Recompiling kernel 2.4.7-10
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Vivek Srivastava <vivs@vt.edu>
Message-ID: <Mahogany-0.64.2-10543-20021002-163958.00@nerijus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <006901c26a1f$db35c5e0$76c211d0@ferrari>
In-Reply-To: <006901c26a1f$db35c5e0$76c211d0@ferrari>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002 10:27:37 -0400 Vivek Srivastava <vivs@vt.edu> wrote:

> Hello Group,
> I am a newbie to Linux. I have Linux Rh 7.2 installed on my Dell Latitude
> C640 Laptop. It is partitioned with Win 2K professional as the other OS. I
> included some Xircom and Cisco WLAN card modules in the kernel configuration
> and recompiled the kernel. A problem then came up when I rebooted my machine
> with the new kernel. It failed to mount my root file system.

Most likely you forgot mkinitrd.

Regards,
Nerijus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317815AbSGKLLI>; Thu, 11 Jul 2002 07:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317816AbSGKLLH>; Thu, 11 Jul 2002 07:11:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:2265 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317815AbSGKLLH>; Thu, 11 Jul 2002 07:11:07 -0400
Date: Thu, 11 Jul 2002 13:13:49 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Peter Zelezny <zed@linux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 link failed `init_rootfs'
In-Reply-To: <20020711200339.2f93f773.zed@linux.com>
Message-ID: <Pine.NEB.4.44.0207111313260.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2002, Peter Zelezny wrote:

> Hi,

Hi Peter,

> 2.4.19-rc1 fails to link:
>
> fs/fs.o: In function `mnt_init':
> fs/fs.o(.text.init+0x8d2): undefined reference to `init_rootfs'
>...

could you send your .config?

TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


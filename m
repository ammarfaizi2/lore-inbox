Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317519AbSFKTdg>; Tue, 11 Jun 2002 15:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317522AbSFKTdf>; Tue, 11 Jun 2002 15:33:35 -0400
Received: from [195.39.17.254] ([195.39.17.254]:42402 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317519AbSFKTdf>;
	Tue, 11 Jun 2002 15:33:35 -0400
Date: Tue, 11 Jun 2002 11:06:52 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020611110651.C38@toy.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D048CFD.2090201@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!!

>  						printk("i2c-core.o: while "
>  						       "unregistering driver "
>  						       "%s' could not
> -						       be detached; driver
> -						       not unloaded!",
> +						       "address %02x of "
> +						       "adapter 

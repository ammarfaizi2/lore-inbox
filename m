Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSEaM7Y>; Fri, 31 May 2002 08:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSEaM7X>; Fri, 31 May 2002 08:59:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S312560AbSEaM7X>; Fri, 31 May 2002 08:59:23 -0400
Date: Fri, 31 May 2002 08:59:08 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andrey Panin <pazke@orbita1.ru>
cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT fs printk() cleanup
In-Reply-To: <20020531125045.GA310@pazke.ipt>
Message-ID: <Pine.LNX.3.95.1020531085628.185A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think it needs to go only to the console....

File-system error...
   printk(...to the file system)
      makes a file-system error...
          <forever>



Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


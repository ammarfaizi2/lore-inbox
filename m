Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315209AbSEDUO7>; Sat, 4 May 2002 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSEDUO7>; Sat, 4 May 2002 16:14:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21518 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315209AbSEDUO6>;
	Sat, 4 May 2002 16:14:58 -0400
Message-ID: <3CD44120.7080709@mandrakesoft.com>
Date: Sat, 04 May 2002 16:14:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/00200203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Regina Kodato <reginak@cyclades.com>, linux-kernel@vger.kernel.org,
        akpm@zip.com.au
Subject: Re: [2.5 patch] s|linux/malloc.h|linux/slab.h| in drivers/net/wan/pc300_tty.c
In-Reply-To: <Pine.NEB.4.44.0205041738540.283-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>Hi Regina,
>
>the patch below fixes the compilation of pc300_tty.c in 2.5.13 and
>2.5.13-dj2:
>


I'm completely amazed this slipped past me, since I did compile tests 
when I merged it.

Thanks much for the patch.

    Jeff





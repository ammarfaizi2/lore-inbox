Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSEGOSa>; Tue, 7 May 2002 10:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315553AbSEGOS3>; Tue, 7 May 2002 10:18:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:12300 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315503AbSEGOS2>; Tue, 7 May 2002 10:18:28 -0400
Message-ID: <3CD7D36A.6050209@evision-ventures.com>
Date: Tue, 07 May 2002 15:15:22 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Padraig Brady <padraig@antefacto.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CD7B8FE.1020505@evision-ventures.com> <3CD7DE62.3060209@antefacto.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Padraig Brady napisa?:

> Am I going to have to parse hdparm output?
> ....
>  geometry     = 2434/255/63, sectors = 39102336, start = 0
> 
> Am I going to need hdparm on my embedded system?

Yes. Or just fsck hardcode the defaults.


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSEVJKD>; Wed, 22 May 2002 05:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSEVJKD>; Wed, 22 May 2002 05:10:03 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23822 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316898AbSEVJKC> convert rfc822-to-8bit; Wed, 22 May 2002 05:10:02 -0400
Message-ID: <3CEB518F.3020404@evision-ventures.com>
Date: Wed, 22 May 2002 10:06:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita1.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Serverworks IDE driver: missing static
In-Reply-To: <20020522091058.GA312@pazke.ipt>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Andrey Panin napisa³:
> Hi,
> 
> svwks_tune_chipset() function contains 3 arrays which IMHO should be static.
> Attached patch fixed it, saving for me 48 bytes of code :))
> Compiles, but untested. Please consider applying.
> 
> Best regards.


Considered and applied of course.


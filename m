Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314420AbSEBNwN>; Thu, 2 May 2002 09:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314439AbSEBNwM>; Thu, 2 May 2002 09:52:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57100 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314420AbSEBNwM>; Thu, 2 May 2002 09:52:12 -0400
Message-ID: <3CD135D4.5060506@evision-ventures.com>
Date: Thu, 02 May 2002 14:49:24 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
In-Reply-To: <28926.1020342106@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Keith Owens napisa?:

> kbuild 2.5 deliberately does not support modversions, you can turn it
> on but it does nothing.  The original implementation of modversions
> does not fit with the way that people build kernels now (apply patches,
> change configs, rebuild without make mrproper).  To do modversions
> right needs a new version of modutils as well, there is no chance of
> that work being started until kbuild 2.5 is in the kernel.

How many years was it that I was telling that symbol versioning is
a silly concept not solving any single problem and the implementation is to say
the least ugly?


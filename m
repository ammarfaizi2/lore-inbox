Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263457AbSITU2h>; Fri, 20 Sep 2002 16:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263460AbSITU2h>; Fri, 20 Sep 2002 16:28:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263457AbSITU2g>;
	Fri, 20 Sep 2002 16:28:36 -0400
Message-ID: <3D8B8606.8040409@mandrakesoft.com>
Date: Fri, 20 Sep 2002 16:33:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.37 - xtime to do_gettimeofday() in drivers/atm/*c
References: <20020920220748.A14520@fafner.intra.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Greetings,
> 
>   simple xtime to do_gettimeofday() as indicated in the subject.


chuckle... was just about to apply these, from another source.

Ideally we want to avoid do_gettimeofday, but it's not a huge deal so 
these are fine...


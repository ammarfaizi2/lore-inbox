Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316163AbSETRkR>; Mon, 20 May 2002 13:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316165AbSETRkQ>; Mon, 20 May 2002 13:40:16 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:10151 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S316163AbSETRkP>;
	Mon, 20 May 2002 13:40:15 -0400
Date: Mon, 20 May 2002 19:40:07 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Henrique Gobbi <henrique@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FIB: Insertion of a route
Message-ID: <20020520194007.A22763@fafner.intra.cogenit.fr>
In-Reply-To: <02052013554203.00840@henrique.cyclades.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Henrique Gobbi <henrique@cyclades.com> :
[...]
> I have a struct device and the destination address. What I have to do to add 
> the new route to the system from the kernel-space.

less +/SIOCADDRT net/ipv4/fib_frontend.c

-- 
Ueimor

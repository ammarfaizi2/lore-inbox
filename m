Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273488AbRIQF5n>; Mon, 17 Sep 2001 01:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273490AbRIQF5d>; Mon, 17 Sep 2001 01:57:33 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:58352 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S273488AbRIQF5Y>; Mon, 17 Sep 2001 01:57:24 -0400
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no
Subject: Re: Linux 2.4.9-ac11
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 17 Sep 2001 07:57:38 +0200
In-Reply-To: <200109170049.f8H0nkEa008317@sleipnir.valparaiso.cl> (Horst von Brand's message of "Sun, 16 Sep 2001 20:49:46 -0400")
Message-ID: <m366ail5pp.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@sleipnir.valparaiso.cl> writes:

> Boots and panics immediately "trying to kill init"

Backout the changes to fs/locks.c or the patch of Trond :

http://marc.theaimsgroup.com/?l=linux-kernel&m=100019824200351&w=2

> 
> i686, stock config with many modules. Config has worked here for ages.


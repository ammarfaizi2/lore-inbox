Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRHWOlb>; Thu, 23 Aug 2001 10:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRHWOlW>; Thu, 23 Aug 2001 10:41:22 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:8712 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267534AbRHWOlQ>;
	Thu, 23 Aug 2001 10:41:16 -0400
Date: Thu, 23 Aug 2001 11:41:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Ivan Kalvatchev <iive@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernelbug <linux-kernel@vger.kernel.org>,
        Andrey Savochkin <saw@saw.sw.com.sg>,
        Szabolcs Szakacsits <szaka@f-secure.com>
Subject: Re: if (malloc() == HORROR_WITHIN) BUG();
In-Reply-To: <20010823135514.93176.qmail@web13601.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0108231140430.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001, Ivan Kalvatchev wrote:

> It is normal all requested memory to be allocated
> before malloc returns any result.

Interesting assertion. Do you have any arguments
to back it up?

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbRFZKQC>; Tue, 26 Jun 2001 06:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRFZKPw>; Tue, 26 Jun 2001 06:15:52 -0400
Received: from [203.143.19.4] ([203.143.19.4]:27144 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S263960AbRFZKPj>;
	Tue, 26 Jun 2001 06:15:39 -0400
Date: Mon, 25 Jun 2001 22:58:23 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Fabian Arias <dewback@vtr.net>, Anuradha Ratnaweera <anuradha@gnu.org>,
        Anatoly Ivanov <avi@levi.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
Message-ID: <20010625225823.B431@bee.lk>
In-Reply-To: <dewback@vtr.net> <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Jun 24, 2001 at 01:33:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 01:33:51PM -0400, Horst von Brand wrote:
> Fabian Arias <dewback@vtr.net> said:
> 
> What gcc objects to is stuff like:
> 
>    "This is a nice long string
>     that just goes on
>     and on\n"
> 
> which is illegal in C AFAIU. It does not object to:
> 
>    "This long string"
>    "spans several lines, "
>    "but legally.\n"

Agreed. I was incorrectly guessing that the it was the latter.

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.6-pre5)

Don't look now, but the man in the moon is laughing at you.


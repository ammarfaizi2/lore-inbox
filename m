Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286759AbRL1G3U>; Fri, 28 Dec 2001 01:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286762AbRL1G3K>; Fri, 28 Dec 2001 01:29:10 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:54940 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S286759AbRL1G2z>; Fri, 28 Dec 2001 01:28:55 -0500
Date: Fri, 28 Dec 2001 08:27:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.17: Dell Laptop extra buttons patch (fwd)
Message-ID: <Pine.LNX.4.33.0112280825220.18421-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't have a Dell laptop, but AFAIK in the past patches like this have
>been rejected by Andries Brouwer (I think) because it is possible to do
>this from user space with key mapping tools like setkeycodes, xkeycaps,
>or xmodmap.

I can't see a possible reason _not_ to have it in there anyway, the 0
values take up space so bloat is not a valid reason. I can understand that
since its possible in userland we should leave it there, but this is
fairly harmless stuff which doesn't affect anything.

Regards,
	Zwane Mwaikambo





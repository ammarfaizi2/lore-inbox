Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289930AbSAKMZR>; Fri, 11 Jan 2002 07:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289931AbSAKMZB>; Fri, 11 Jan 2002 07:25:01 -0500
Received: from svr3.applink.net ([206.50.88.3]:2826 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289930AbSAKMYo>;
	Fri, 11 Jan 2002 07:24:44 -0500
Message-Id: <200201111224.g0BCOYSr001179@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: "David S. Miller" <davem@redhat.com>, timothy.covell@ashavan.org
Subject: Re: strange kernel message when hacking the NIC driver
Date: Fri, 11 Jan 2002 06:20:42 -0600
X-Mailer: KMail [version 1.3.2]
Cc: zhengpei@msu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <LIECKFOKGFCHAPOBKPECEEGCCNAA.zhengpei@msu.edu> <200201111159.g0BBxCSr001144@svr3.applink.net> <20020111.040715.48529485.davem@redhat.com>
In-Reply-To: <20020111.040715.48529485.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 January 2002 06:07, David S. Miller wrote:
>    From: Timothy Covell <timothy.covell@ashavan.org>
>    Date: Fri, 11 Jan 2002 05:55:20 -0600
>
>    Let me clarify what I said earlier.  You cannot have
>    identical MAC addresses on two different NICs.
>
> There is nothing illegal about that at all.  As long at
> the NICs live on different subnets, it is perfectly fine.
> In fact this is pretty common on Sun machines.

True.  I was assuming that the context of the post was
that the NICs were on the same network link.    

Solaris _defaults_ to using the MAC address from the 
primary (hostname) NIC for the rest of them.   IMHO, this 
is a really stupid thing to do, and  I disable it tout de suite
when given a choice.   Of course, if you like it, then
why don't you try to convince Linus to change his mind 
about it?

-- 
Surah II 120, Surah II 191-193, Surah V 45, Surah V 51
Surah VIII 12-18, Surah VIII 39-40, Surah VIII 65-69, etc.
--
timothy.covell@ashavan.org.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132312AbRARP3Y>; Thu, 18 Jan 2001 10:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRARP3O>; Thu, 18 Jan 2001 10:29:14 -0500
Received: from adsl-nrp10-C8B0F87C.sao.terra.com.br ([200.176.248.124]:31219
	"EHLO thor.gds-corp.com") by vger.kernel.org with ESMTP
	id <S132312AbRARP3M> convert rfc822-to-8bit; Thu, 18 Jan 2001 10:29:12 -0500
Date: Thu, 18 Jan 2001 13:30:09 -0200 (BRST)
From: Joel Franco Guzmán <joel@gds-corp.com>
To: Mike Dresser <mdresser@windsormachine.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <3A670078.E8DF3229@windsormachine.com>
Message-ID: <Pine.LNX.4.30.0101181325550.1017-100000@thor.gds-corp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2001, Mike Dresser wrote:

> Sorry if this has been asked of you before, but what happens if you put just
> the 64 meg module in?

Ok. i've not analised that possibility. I've tested that just now.
But, the system work perfect. Without the sound card problem.
I've exchanged the modules. FAIL.
The memory sets in the BIOS is 3-3-3-10.
The 64M and the 128M is PC100.
Another more one thing. I think that be a software problem, because with
the kernel 2.2.18 it's not happening.

thank you, Mike.
>
> > Bug Report
> > ----------
> > 1. 128M memory OK, but with 192M the sound card generate a noise while
> > use the DSP.
> > 2. i got the problem when I just put more 64M memory to the my machine.
> > With 128M the problem is not present, but with 192M it is. The only
> > difference is the memory quantity, or in other words, the additional slot
> > occupied by the new memory card.
>
> My instinct is the pc100 ram being run at 133.  Sometimes you get away with
> it(my pre-ratings, but supposed to be pc66 - hyundai ram runs at 100 just
> fine, but won't go any higher), and maybe your new 64 megger can't do it.
>
> Mike Dresser
>

-- 
    Joel Franco Guzmán
GDS - Global Dynamic Systems
   joelfranco@bigfoot.com
ICQ 19354050 | (16) 270-6867

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270090AbRHMLJO>; Mon, 13 Aug 2001 07:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270089AbRHMLJD>; Mon, 13 Aug 2001 07:09:03 -0400
Received: from arminho.ip.pt ([195.23.132.10]:14096 "HELO arminho.ip.pt")
	by vger.kernel.org with SMTP id <S270087AbRHMLIr>;
	Mon, 13 Aug 2001 07:08:47 -0400
Message-ID: <20010813110855.9358.qmail@webmail.clix.pt>
X-Originating-IP: [198.62.9.29]
X-Mailer: Clix Webmail 2.0
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu>
In-Reply-To: <E15W1eR-000691-00@the-village.bc.nu> 
From: "rui.p.m.sousa@clix.pt" <rui.p.m.sousa@clix.pt>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: manuel@mclure.org (Manuel McLure), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Date: Mon, 13 Aug 2001 11:08:54 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:

Did you have any lockups with non Athlon
motherboards?

>> On 2001.08.12 05:04 Alan Cox wrote:
>> > The in kernel one seemed fine. The 2.4.8 update one is definitely broken
>> > on
>> > SMP boxes
>> 
>> I'm getting 2.4.8 Oopsen that seem to be in emu10k1 code on UP - see my
>> message "2.4.8 oops in ksoftirqd_CPU0"...
> 
> Yep. So far the new driver that Linus took from a non maintaier breaks
> 
> 	SMP
> 	Some mixers
> 	Uniprocessor with some cards
> 	Surround sound (spews noise on cards)
> 
> so I think Linus should do the only sane thing - back it out. I'm backing
> it out of -ac. Of my three boxes, one spews noise, one locks up smp and
> one works.
> 
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/






--
Crie o seu Email Grátis no Clix em
http://registo.clix.pt/

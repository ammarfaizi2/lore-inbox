Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbRGRQK4>; Wed, 18 Jul 2001 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267903AbRGRQKr>; Wed, 18 Jul 2001 12:10:47 -0400
Received: from web13806.mail.yahoo.com ([216.136.175.16]:9736 "HELO
	web13806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267901AbRGRQKc>; Wed, 18 Jul 2001 12:10:32 -0400
Message-ID: <20010718161027.31750.qmail@web13806.mail.yahoo.com>
Date: Wed, 18 Jul 2001 09:10:27 -0700 (PDT)
From: <gdrago23@yahoo.com>
Subject: LDP / KDP?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Samuels (charles@kde.org) wrote:
> I apologize for using the D-word, however, I've 
> created some, so I think that makes it acceptable. 
>
> But first, I was having a little fun kernel-hacking 
> the other day, and I had noticed that every time I 
> want information on function-X, I have to start 
> grepping like hell, and it's even worse when I don't

> know the name of the function. What we needed was an

> API (KPI?) reference. 
>
> So I made one. 
>
>
> <blink><marquee> http://derkarl.org/kerneldoc/ 
> </marquee></blink> 
> (It seems that 10% of europe can't get that domain: 
> 207.44.242.45) 
>
> Obviously, it's not complete, in fact, if it were 
> any less complete, I could call it the linux 
> kernel :) 
>
> The _real_ reason I post this message is, of course,

> for help. I'll be more than happy to accept new xml 
> documentation files (the bottom of each page 
> contains a link to the associated XML file, as an 
> example). 
>
> PS. I'm not on this mailing list (I'm on plenty, 
> don't worry), so I'll be following it on the 
> archives. 
>
> -Charles 

(I'm only quoting your whole message because I'm
cc'ing it to discuss@linuxdoc.org.)

Have you considered writing this as an LDP Guide?

Advantages:
* Harness the incredible power of a virtual army of
LDP volunteers. (Well, a virtual platoon...)
* The docs become print-ready as well.
* DocBook is a standard! Yay standards!
* Use the already-present distribution network the LDP
has in place.

Disadvantages:
* Your formatting looks spiffier than the LDP
stylesheets.
* You'd have to rewrite what you have.
* DocBook is not tailored to your purposes.
* Multiple versions will exist throughout the world.

I believe it's an alternative worth considering. I'd
be willing to convert what you already have to
DocBook.

-adam buchbinder



__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130099AbRBVSwG>; Thu, 22 Feb 2001 13:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRBVSv4>; Thu, 22 Feb 2001 13:51:56 -0500
Received: from palrel1.hp.com ([156.153.255.242]:13061 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S130099AbRBVSvr>;
	Thu, 22 Feb 2001 13:51:47 -0500
Message-ID: <3A9556A7.D052D8A6@cup.hp.com>
Date: Thu, 22 Feb 2001 10:12:55 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nye Liu <nyet@curtis.curtisfong.org>, linux-kernel@vger.kernel.org
Subject: Re: Very high bandwith packet based interface and performance problems
In-Reply-To: <E14Vsrg-0003pw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > TCP _requires_ the remote end ack every 2nd frame regardless of progress.
> >
> > um, I thought the spec says that ACK every 2nd segment is a SHOULD not a
> > MUST?
> 
> Yes its a SHOULD in RFC1122, but in any normal environment pretty much a
> must and I know of no stack significantly violating it.

I didn't know there was such a thing as a normal environment :)

> RFC1122 also requires that your protocol stack SHOULD be able to leap tall
> buldings at a single bound of course...

And, of course my protocol stack does :) It is also a floor wax, AND a
dessert topping!-)

rick jones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130425AbRAROmG>; Thu, 18 Jan 2001 09:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135773AbRAROl4>; Thu, 18 Jan 2001 09:41:56 -0500
Received: from windsormachine.com ([206.48.122.28]:16399 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S135772AbRAROlq>; Thu, 18 Jan 2001 09:41:46 -0500
Message-ID: <3A670078.E8DF3229@windsormachine.com>
Date: Thu, 18 Jan 2001 09:40:56 -0500
From: Mike Dresser <mdresser@windsormachine.com>
Organization: Windsor Machine & Stamping
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Joel Franco Guzmán <joel@gds-corp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this has been asked of you before, but what happens if you put just
the 64 meg module in?

> Bug Report
> ----------
> 1. 128M memory OK, but with 192M the sound card generate a noise while
> use the DSP.
> 2. i got the problem when I just put more 64M memory to the my machine.
> With 128M the problem is not present, but with 192M it is. The only
> difference is the memory quantity, or in other words, the additional slot
> occupied by the new memory card.

My instinct is the pc100 ram being run at 133.  Sometimes you get away with
it(my pre-ratings, but supposed to be pc66 - hyundai ram runs at 100 just
fine, but won't go any higher), and maybe your new 64 megger can't do it.

Mike Dresser


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

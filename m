Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273086AbRIIWaP>; Sun, 9 Sep 2001 18:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273084AbRIIW34>; Sun, 9 Sep 2001 18:29:56 -0400
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:23697 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273083AbRIIW3r>; Sun, 9 Sep 2001 18:29:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "J. Dow" <jdow@earthlink.net>, "Carsten Leonhardt" <leo@debian.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/K7-Opimisation problems
Date: Sun, 9 Sep 2001 15:29:25 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <87g09w70o4.fsf@cymoril.oche.de> <01090915115400.00173@c779218-a> <063301c1397e$0efa6d00$1125a8c0@wednesday>
In-Reply-To: <063301c1397e$0efa6d00$1125a8c0@wednesday>
MIME-Version: 1.0
Message-Id: <01090915292502.00173@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 September 2001 03:23 pm, J. Dow wrote:
> From: "Nicholas Knight" <tegeran@home.com>
>
> > > The only difference I can make out between the working and the
> > > non-working CPU is the internal clockspeed of the CPU and the
> > > stepping (old: 2, new: 4).
> >
> > Heat anyone? stepping 4 hasn't seemed to be the problem, at least not
> > directly
> > What's the tempature difference between your 1Ghz and 1.4Ghz? both
> > CPU and system? What kind of cooling do you have?
>
> What about the power supply. If it is at all marginal the power
> consumption boost going to 1.4G is likely a killer.

Well, he didn't mention the amperage outputs, but he said 431W Enermax, 
from what I hear Enermax PSU's are good.
I still have trouble dealing with the idea that the optimizations cause 
power consumption like this, but then, I have trouble with my own idea 
that it causes sufficient heat increase in the chipset that soon after 
boot.

Do most people that experience this problem also experience after a 
cold-boot where the system had been off for at least 10-15 minutes? And 
has ANYONE sucsesfully cured this problem by changing power supplies?

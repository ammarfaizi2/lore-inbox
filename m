Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUH0Q1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUH0Q1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUH0Q1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:27:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:15370 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266519AbUH0Q0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:26:25 -0400
Message-Id: <6.1.2.0.2.20040827171755.01c1f328@inet.uni2.dk>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Fri, 27 Aug 2004 18:26:14 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Kenneth Lavrsen <kenneth@lavrsen.dk>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >
 > Indeed, it's a real shame.
 > Everybody should never forget, as history tells, that extremist positions
 > quickly lead to destruction.
 > I hope that open source movement will never become fundamentalism.
 >

My name is Kenneth Lavrsen. I maintain the open source project Motion.
Probably half of the users of Motion - and there are 1000s of them will 
soon realise that next time they download a Kernel their camera will no 
longer work.

I wonder if the people that decided to take out the pwc driver from the 
Kernel considered anyone else than themselves?

When Greg decided to remove the hook that enabled the use of pwcx HE 
decided to remove the driver. In practical the pwc driver is worthless 
without pwc. Completely worthless. The tiny picture size supported without 
pwcx is not worth anything. pwc goes hand in hand with pwcx. This is a 
fact. When you decide to remove the possibility to use pwcx you cripple pwc 
so that it is useless.
Greg decided that for fanatic and extremist reasons the 10000s - maybe 
100000s - of people that have invested in a Webcamera like a Logitech or 
Philips can throw away their camera if they want to keep their Linux 
systems up to date in future.
I personally have 8 such cameras worth a fortune in working action and as a 
Linux user I am so disappointed and angry with the way that the maintainers 
(or is it in reality a single individual with too much power?) are 
threating me and the many other Linux users.

And what about Nemosoft. Ideally it is pretty wrong of him to pull off the 
driver from his site. That makes things even worse.
And his threads and ultimatum was not very nice either.But when you go back 
and search for the mailing that has taken place between a few kernel 
maintainers (lately Greg) it is easy to understand why Nemosoft is angry 
and feel hurt and badly treated.
It is easy to see that the whole thing turned into a personal conflict 
between Nemosoft and Greg.
And the way I read it - Nemosoft has been treated in an unfair and arrogant 
way. Nemosoft is not a machine. He is a human and react as a human after 
having been stepped on for a long time. It seems that a few fundamentalists 
have picked on Nemosoft in their private war against anything closed 
sourced. For a single individual working on a driver for no personal gain - 
for no pay - - this is more than you can expect anyone to accept.
There has been problems with the driver in connection with kernel 2.6. Some 
were real problems where a proper member of an open source community should 
help and assist in finding the solution instead of just arrogantly marking 
code bad.

And now the latest step of modifying the code so that it is useless like 
removing the hook for pwcx. I have been using pwc/pwcx for years now and 
the driver has been working well. Better than so many other USB based 
devices I have tried and rejected.
The binary pwcx module has been accepted for years. And now fanatism has 
taken over and suddenly the pwcx module is no longer pure. And it does not 
seem like Greg spent even one second thinking about the 10000s of people 
that have invested in the quite expensive (but much better than anything 
else) Logitech and Philips cameras - knowing that it was supported by 
Linux. He just destroyed the driver without a wink.
Did he think: "To hell with all the Linux users with a USB camera - I don't 
care about other people - I care only about my own principles"?

Kernel developers sits with the power to reject incoming patches. Such 
priviledge should be handled with respect. Not only to the individual 
contributors - but also to the millions of Linux users that depends on 
their behavour. What I have seen is in my eyes abuse of this power.
I would never remove a feature from Motion without a proper debate with my 
users. Being a maintainer of an OSS project is a priviledge - not a right.

I sincerely hope that Nemosoft will return and that he will be better 
received when he does.

And to all those kernel developers on this list. Remember that there are 
millions of Linux users now. And if you start removing support of people 
already purchased hardware for whatever religious reason - you will 
eventually kill Linux - because then you force people back to Windows.

Right now I have a hard time finding the motivation to continue spending 
10-20 hours per week maintaining the Motion project because of this. I am 
really angry and disappointed. This is not what I had expected from a 
community that that has been so great.

Kenneth


-- 
Kenneth Lavrsen,
Glostrup, Denmark
kenneth@lavrsen.dk
Home Page - http://www.lavrsen.dk 



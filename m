Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287896AbSA3Bge>; Tue, 29 Jan 2002 20:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSA3BgS>; Tue, 29 Jan 2002 20:36:18 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:3077 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S287880AbSA3Bf4>;
	Tue, 29 Jan 2002 20:35:56 -0500
Message-Id: <5.1.0.14.0.20020130123300.02325d10@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 30 Jan 2002 12:35:52 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: A modest proposal -- We need a patch penguin
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Nathan Scott <nathans@sgi.com>, Andreas Gruenbacher <ag@bestbits.at>
In-Reply-To: <Pine.LNX.4.33.0201291552170.1747-100000@penguin.transmeta.
 com>
In-Reply-To: <20020130104004.C81308@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:59 PM 29/01/02 -0800, Linus Torvalds wrote:
>Basically, you should always consider email to me to be a unreliable
>medium, with no explicit congestion control. So think of an email like a
>TCP packet, with exponential backoff - except the times are different (in
>TCP, the initial timeout is three seconds, and the max timeout is 2
>minutes. In "Linus-lossy-network" it makes sense to use different
>default and maximum values ;)

Actually it's more like UDP. *grin* Least with TCP we get an ACK that the 
connection is accepted, and some sort of status is kept. Not so sure we 
have that with you all the time.

But hey, lots of things run over UDP, just a matter of making sure everyone 
realizes it's not a guaranteed medium really, isn't it?


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]


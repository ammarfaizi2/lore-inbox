Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289588AbSAWAhW>; Tue, 22 Jan 2002 19:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSAWAhM>; Tue, 22 Jan 2002 19:37:12 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:17668 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S289588AbSAWAhA>;
	Tue, 22 Jan 2002 19:37:00 -0500
Message-Id: <5.1.0.14.0.20020123112137.009ef8b0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 23 Jan 2002 11:36:56 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: Athlon PSE/AGP Bug
Cc: Steve Brueggeman <xioborg@yahoo.com>
In-Reply-To: <c5qr4uk3adm53fgvuibld2tnjtnfnq0a5i@4ax.com>
In-Reply-To: <1011737673.10474.12.camel@psuedomode>
 <1011610422.13864.24.camel@zeus>
 <20020121.053724.124970557.davem@redhat.com>
 <20020121.053724.124970557.davem@redhat.com>
 <20020121175410.G8292@athlon.random>
 <3C4C5B26.3A8512EF@zip.com.au>
 <o7cp4ukpr9ehftpos1hg807a9hfor7s55e@4ax.com>
 <hbep4uka8q6t1tfv6694sjtvfrulipg3a4@4ax.com>
 <87k7uakutl.fsf@CERT.Uni-Stuttgart.DE>
 <1011737673.10474.12.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:52 PM 22/01/02 -0600, Steve Brueggeman wrote:
>I would like to see some indication that someone is collecting data
>related to "running stable with mem=nopentium on Athelon
>architecture", and maybe we can see a pattern here.  Heck maybe we see
>2 or 3 different patterns here.

Well I'm quite willing to give all the system specs we have at work and the 
ones I have at home (all up, this is about 12 Athlon's that are running 
Linux, all running fine so far with no issues) towards this process.

I've not seen your system specs, so I'm wondering what sort of m/board you 
have? The mention of the SiS AGP support makes me wonder if you are running 
an SiS chipset board. In the past, Linux kernel developers and the XFree86 
team have had a huge amount of trouble (or in some cases, flat refusal) in 
getting certain (usually up to date) specs out of SiS, and I'm wondering if 
maybe this could be related somehow, as none of the systems I've got have 
an SiS chipset in them (they are all AMD or VIA chipsets).

Now I'm not saying this is an SiS issue, but maybe it's more prevalent with 
SiS chipsets? Until we get some hard data, who knows!


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]


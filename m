Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRDEBof>; Wed, 4 Apr 2001 21:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDEBoZ>; Wed, 4 Apr 2001 21:44:25 -0400
Received: from cy57850-a.rdondo1.ca.home.com ([24.5.132.106]:26637 "HELO
	firewall.philstone.com") by vger.kernel.org with SMTP
	id <S132539AbRDEBoP>; Wed, 4 Apr 2001 21:44:15 -0400
Date: Wed, 04 Apr 2001 18:41:10 -0700
From: Christopher Smith <x@xman.org>
To: "Carey B. Stortz" <castortz@nmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Signal Handling Performance?
Message-ID: <50490000.986434870@hellman>
In-Reply-To: <5.0.0.25.2.20010404211904.009d3eb0@pop.mail.nmu.edu>
X-Mailer: Mulberry/2.0.8 (Linux/x86 Demo)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, April 04, 2001 21:30:51 -0400 "Carey B. Stortz" 
<castortz@nmu.edu> wrote:
> either stayed the same or had a performance increase. A general decrease
> started around kernel 2.1.32, then performance drastically fell at kernel
> 2.3.20. There is an Excel graph which shows the trend at:
>
> http://euclid.nmu.edu/~benchmark/Carey/signalhandling.gif
>
> I was wondering if anybody had any ideas why this is happening, and what
> happened in kernel 2.3.20 to cause such a decrease in performance?

Lies, damn lies, and benchmarks. ;-) Seriously though, I'm not clear on 
what you are measuring or how you are measuring it. It looks like this is 
measuring signal latency, which is important, but what about thoroughput?

--Chris

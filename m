Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286842AbRL1K5Z>; Fri, 28 Dec 2001 05:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286836AbRL1K5G>; Fri, 28 Dec 2001 05:57:06 -0500
Received: from [212.50.10.141] ([212.50.10.141]:60878 "HELO ns.top.bg")
	by vger.kernel.org with SMTP id <S286843AbRL1K5B>;
	Fri, 28 Dec 2001 05:57:01 -0500
Message-ID: <3C2CDCC3.B76C9944@top.bg>
Date: Fri, 28 Dec 2001 12:57:39 -0800
From: Anton Tinchev <atl@top.bg>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EEPro100 problems in SMP on 2.4.5 ?
In-Reply-To: <Pine.LNX.4.33.0112281248190.29899-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, in me this cards lockups between 2-3 days.

Zwane Mwaikambo wrote:

> On Fri, 28 Dec 2001, Anton Tinchev wrote:
>
> > The problem is with the kernel driver - i locks under heavy load (over 2
> > 000-3 000 packet/s, may be less).
> > Change the card if you can, i didn't recommend you this card for production
> > server.
>
> Unfortunately it was the onboard one, plus a rather cool dual eepro100
> card. And yes the server does experience quite a load when everyone is in
> the office. But not the lockups everyone else seems to be experiencing.
>
> Cheers,
>         Zwane Mwaikambo


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280989AbRKOSpr>; Thu, 15 Nov 2001 13:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280992AbRKOSpi>; Thu, 15 Nov 2001 13:45:38 -0500
Received: from freeside.toyota.com ([63.87.74.7]:7435 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S280991AbRKOSpZ>; Thu, 15 Nov 2001 13:45:25 -0500
Message-ID: <3BF40D3C.8D3F0369@lexus.com>
Date: Thu, 15 Nov 2001 10:45:16 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: CS423x audio driver updates for testing
In-Reply-To: <E164QJM-0000y2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > > Can folks with cs42xx series audio give it a test make sure it
> > > doesn't break anything
> >
> > Alan: Should I check to see whether these changes need to be ported
> > to ALSA?
>
> I think ALSA is already way ahead on the CS42xx series chips but sure
> check by all means.
>
> > By the way: In your opinion, is ALSA going to get into Linux 2.5?
>
> Something like it I hope - I delegated that question to Zab and Jef

I seem to remember, folks intererested in gaming and
mulitmedia apps had done some latency profiling and
found that the alsa drivers were a source of really bad
latency - am I imagining all this or does it ring a bell
with someone?

That is my main concern, hopefully the ueber geniuses
are already dealing with this issue as we speak, so to
speak...

cu

jjs



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbRHNTcd>; Tue, 14 Aug 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270695AbRHNTcO>; Tue, 14 Aug 2001 15:32:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:51463 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270757AbRHNTcL>;
	Tue, 14 Aug 2001 15:32:11 -0400
Date: Tue, 14 Aug 2001 16:32:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Jon 'tex' Boone" <tex@delamancha.org>
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <m38zgmpin8.fsf@amicus.delamancha.org>
Message-ID: <Pine.LNX.4.33L.0108141631320.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Jon 'tex' Boone wrote:

> > mm/vmscan.c::kswapd()
> > 	else if (out_of_memory()) {
> > 		oom_kill()
> >
> > mm/oom_kill.c::out_of_memory()
>
>     Should said volunteer(s) work with stock 2.4.8?

No real need, the OOM functions are basically unchanged.

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


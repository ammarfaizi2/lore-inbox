Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269489AbRHYPvV>; Sat, 25 Aug 2001 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269481AbRHYPvA>; Sat, 25 Aug 2001 11:51:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56842 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269454AbRHYPuu>;
	Sat, 25 Aug 2001 11:50:50 -0400
Date: Sat, 25 Aug 2001 12:50:51 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825154325Z16125-32383+1325@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108251249510.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Daniel Phillips wrote:

> > True, it's just an issue of performance and heavily used
> > servers falling over under load, nothing as serious as
> > data corruption or system instability.
>
> If your server is falling over under load, this is not the reason.

I bet your opinion will be changed the moment you see a system
get close to falling over exactly because of this.

Remember NL.linux.org a few weeks back, where a difference of
10 FTP users more or less was the difference between a system
load of 3 and a system load of 250 ?  ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


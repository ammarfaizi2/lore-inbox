Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRHZS5f>; Sun, 26 Aug 2001 14:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271431AbRHZS5Z>; Sun, 26 Aug 2001 14:57:25 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59406 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271421AbRHZS5P>;
	Sun, 26 Aug 2001 14:57:15 -0400
Date: Sun, 26 Aug 2001 15:56:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: <pcg@goof.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826172310Z16216-32383+1477@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0108261555340.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Daniel Phillips wrote:
> On August 26, 2001 04:49 am, pcg@goof.com ( Marc) (A.) (Lehmann ) wrote:

> > Anyway, I compiled and bootet into linux-2.4.8-ac9. I jused ac8 on my
> > desktop machines and was not pleased with absolute performance but, unlike
> > the linus' series, I can listen to mp3's while working which was the
> > killer feature for me ;)
>
> Yes, this probably points at a bug in linus's tree.

"It works, it must be a bug!"

> > So the ac9 kernel seems to work much better (than the linus' series),
> > although the number of connections was below the critical limit. I'll
> > check this when I get higher loads again.
>
> The reason for that is still unclear.

I've tried to explain it to you about 10 times now.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271964AbRH2Nu0>; Wed, 29 Aug 2001 09:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271905AbRH2NuQ>; Wed, 29 Aug 2001 09:50:16 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:40964 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271889AbRH2NuH>;
	Wed, 29 Aug 2001 09:50:07 -0400
Date: Wed, 29 Aug 2001 10:49:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The cause of the "VM" performance problem with 2.4.X
In-Reply-To: <20010828212937.B644@telia.com>
Message-ID: <Pine.LNX.4.33L.0108291049220.27250-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2001, André Dahlqvist wrote:
> Linus Torvalds <torvalds@transmeta.com> wrote:
>
> > Note that the real fix is to make the block devices use the page cache.
> > Andrea has patches, but it's a 2.5.x thing.
>
> Linus, could you please make a statement when 2.5.x is likely to start?
> A lot of people wonder this and we all know you have some sort of plan
> laid out. Tell us about it:-)

2.4.8-pre* seems to have been the turning point where
experimental stuff started getting introduced ;)


Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276988AbRJZBMO>; Thu, 25 Oct 2001 21:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276990AbRJZBMH>; Thu, 25 Oct 2001 21:12:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57353 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276988AbRJZBLt>;
	Thu, 25 Oct 2001 21:11:49 -0400
Date: Thu, 25 Oct 2001 23:12:00 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: CaT <cat@zip.com.au>, Marton Kadar <marton.kadar@freemail.hu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: concurrent VM subsystems
In-Reply-To: <Pine.LNX.4.33.0110260033170.8916-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33L.0110252234460.3690-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Oct 2001, Luigi Genoni wrote:

> Obviously I was not meaning that desktops have not to be stable, but
> they are not subjects to long uptimes, at less usually, so page aging
> is, how can I say in correct english?, dealing with different
> conditions...

Interestingly, of all the people saying that we should have
different VM systems for different situations, NOBODY has
managed to point out what specific things should be different.

The current situation of having 2 competing VMs seems to work
out nicely, though. Especially when ideas get merged all the
time.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/


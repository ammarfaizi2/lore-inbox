Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278343AbRJMSSg>; Sat, 13 Oct 2001 14:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278347AbRJMSS2>; Sat, 13 Oct 2001 14:18:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:778 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S278343AbRJMSSR>;
	Sat, 13 Oct 2001 14:18:17 -0400
Date: Sat, 13 Oct 2001 15:18:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110130956350.8707-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0110131517160.2847-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Oct 2001, Linus Torvalds wrote:

> Trust me, MAP_COPY really _is_ stupid, and the Hurd is a piece of crap.

Isn't it a Mach thing ?

> People who think MAP_COPY is a good idea are people who cannot think about
> the implications of it, and cannot think about the alternatives.

I guess thinking about the implications will come when
the Hurd people seriously start porting their beast to
other microkernels, say L4 ;)

This should be a spectacle worth watching (from a safe
distance).

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/  (volunteers needed)

http://www.surriel.com/		http://distro.conectiva.com/


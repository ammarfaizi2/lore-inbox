Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbRGRNXd>; Wed, 18 Jul 2001 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267876AbRGRNXX>; Wed, 18 Jul 2001 09:23:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:28167 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S267874AbRGRNXN>;
	Wed, 18 Jul 2001 09:23:13 -0400
Date: Wed, 18 Jul 2001 10:23:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107172118200.7772-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107181016500.27454-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Marcelo Tosatti wrote:

> The following patch (against 2.4.6-ac2, already merged in 2.4.6-ac3) adds
> specific perzone inactive/free shortage handling code.

Marcelo, now that you have the nice VM statistics
patch, do you have some numbers on how this patch
affects the system, or is this patch based on
guesswork ?  ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


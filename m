Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268649AbRG3WR5>; Mon, 30 Jul 2001 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbRG3WRn>; Mon, 30 Jul 2001 18:17:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49416 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268634AbRG3WRB>; Mon, 30 Jul 2001 18:17:01 -0400
Date: Mon, 30 Jul 2001 19:17:04 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Use-once change and inactive shortage calculation
In-Reply-To: <Pine.LNX.4.21.0107301729470.7432-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107301916250.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Marcelo Tosatti wrote:

> The best solution, IMO, is to unlazy queue movement. Doing this would
> result in accurate inactive/free information.

We won't know until we try, but I think it's a good
thing to try...

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269180AbRHBWHc>; Thu, 2 Aug 2001 18:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269177AbRHBWHW>; Thu, 2 Aug 2001 18:07:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:43269 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269180AbRHBWHN>; Thu, 2 Aug 2001 18:07:13 -0400
Date: Thu, 2 Aug 2001 19:07:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33.0108021448400.21298-100000@heat.gghcwest.com>
Message-ID: <Pine.LNX.4.33L.0108021900080.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:

> Gosh, here's an idea: if there is no memory left and someone
> malloc()s some more, have malloc() fail?  Kill the process that
> required the memory? I can't believe the attitude I am hearing.
> Userland processes should be able to go around doing whaever the
> fuck they want and the box should stay alive.

If you have a proposal on what to do when both ram
and swap fill up and you need more memory, please
let me know.

Until then, we'll kill processes when we exhaust
both memory and swap ;)

cheers,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


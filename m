Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbRGBDAY>; Sun, 1 Jul 2001 23:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266352AbRGBDAO>; Sun, 1 Jul 2001 23:00:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25355 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266347AbRGBC75>; Sun, 1 Jul 2001 22:59:57 -0400
Date: Sun, 1 Jul 2001 23:59:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.33.0107011943240.7587-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0107012358460.9312-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2001, Linus Torvalds wrote:
> On Sun, 1 Jul 2001, Rik van Riel wrote:
> > > "me: undo page_launder() LRU changes, they have nasty side effects"
> > >
> > > Can you be more verbose about this ?
> >
> > I think this was fixed by the GFP_BUFFER vs. GFP_CAN_FS + GFP_CAN_IO
> > thing and Linus accidentally backed out the wrong code ;)
>
> You wish.
>
> Except it wasn't so.
>
> Follow the list, and read the emails that were cc'd to you.

I'll try to find them, but at the moment I'm on a slow
link (was at USENIX and am still a continent away from
where my email is) and I'm afraid I won't have too much
time for kernel stuff the next 3 weeks ;(

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


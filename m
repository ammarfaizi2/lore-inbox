Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270470AbRHHMNB>; Wed, 8 Aug 2001 08:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270473AbRHHMMv>; Wed, 8 Aug 2001 08:12:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:60433 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270470AbRHHMMo>; Wed, 8 Aug 2001 08:12:44 -0400
Date: Wed, 8 Aug 2001 09:12:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x VM problems thread
In-Reply-To: <20010807173255.L22821@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33L.0108080912140.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Mike Fedyk wrote:
> On Wed, Aug 08, 2001 at 02:24:37AM +0200, Luigi Genoni wrote:
> > This kind of code would kill any Unix system, i think, not just linux 2.4
> > boxes.
> >
>
> I tried it on 2.2.19-ppc and could kill it with ^C at the prompt, or from
> root if I was already logged in.  Trying to iniate connections to ssh didn't
> produce any results after about 30 seconds.
>
> Once it was killed the system was fine.
>
> Haven't tried 2.4 yet...

Under 2.4-ac the system should stay usable.

2.4-linus probably dies because the limit on
the number of processes is dangerously high.

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


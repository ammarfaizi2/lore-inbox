Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269127AbRHBU3C>; Thu, 2 Aug 2001 16:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269118AbRHBU2w>; Thu, 2 Aug 2001 16:28:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20746 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269127AbRHBU2q>; Thu, 2 Aug 2001 16:28:46 -0400
Date: Thu, 2 Aug 2001 17:28:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <Pine.LNX.4.33L.0108021714070.5582-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0108021728130.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2001, Rik van Riel wrote:
> On Thu, 2 Aug 2001, Jeffrey W. Baker wrote:
>
> > I'm about the zillionth person to complain about this problem on
> > this list.  It is completely unacceptable to say that I can't
> > use the memory on my machines because the kernel is too hungry
> > for cache.
>
> Fully agreed. The problem is that getting a solution which
> works in a multizoned VM isn't all that easy, otherwise we
> would have fixed it ages ago ...

Well, actually there are a few known solutions to this
problem, but they are not really an option for the 2.4
series since they require large code changes...

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRERSDL>; Fri, 18 May 2001 14:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbRERSDB>; Fri, 18 May 2001 14:03:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:25613 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261309AbRERSCx>; Fri, 18 May 2001 14:02:53 -0400
Date: Fri, 18 May 2001 15:02:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: virii <virii@gcecisp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: cmpci sound chip lockup
In-Reply-To: <20010517135808.G754@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.33.0105181501590.5251-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2001, Ingo Oeser wrote:
> On Wed, May 16, 2001 at 08:02:06PM -0300, Rik van Riel wrote:
> > I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
> > serious way. Using xmms the music stops after anything between
> > a few seconds and a minute, I suspect a race condition somewhere.
> >
> > Using mpg123 everything works fine...
>
> Your xmms uses esd[1]?

Nope. I also get this with xmms directly to /dev/dsp.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


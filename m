Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRCYSBD>; Sun, 25 Mar 2001 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRCYSAx>; Sun, 25 Mar 2001 13:00:53 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20740 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132140AbRCYSAm>; Sun, 25 Mar 2001 13:00:42 -0500
Date: Sun, 25 Mar 2001 14:08:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <3ABE0CC2.268D8C3C@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0103251407420.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001, Martin Dalecki wrote:
> Rik van Riel wrote:

> > - the AGE_FACTOR calculation will overflow after the system has
> >   an uptime of just _3_ days
> 
> I esp. the behaviour will be predictable.

Ummmm ?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


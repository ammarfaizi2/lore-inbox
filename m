Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130082AbRCAWjV>; Thu, 1 Mar 2001 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130081AbRCAWjO>; Thu, 1 Mar 2001 17:39:14 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20468 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130079AbRCAWjG>; Thu, 1 Mar 2001 17:39:06 -0500
Date: Thu, 1 Mar 2001 19:38:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Chris Evans <chris@scary.beasts.org>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.30.0103012232040.21550-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.33.0103011937560.1304-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Chris Evans wrote:
> On Thu, 1 Mar 2001, Rik van Riel wrote:
>
> > True. I think we want something in-between our ideas...
>         ^^^^^^^
> > a while. This should make it possible for the disk reads to
>                 ^^^^^^
>
> Oh dear.. not more "vm design by waving hands in the air". Come
> on people, improve the vm by careful profiling, tweaking and
> benching, not by throwing random patches in that seem cool in
> theory.

Actually, this was more of "vm design by looking at what
the FreeBSD folks did, why it didn't work and how they
fixed it after 2 years of testing various things".

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


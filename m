Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbREYSA1>; Fri, 25 May 2001 14:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbREYSAS>; Fri, 25 May 2001 14:00:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33035 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261353AbREYSAG>; Fri, 25 May 2001 14:00:06 -0400
Date: Fri, 25 May 2001 14:59:57 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: <linux-kernel@vger.kernel.org>, <mc@cs.Stanford.EDU>
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <200105242104.OAA29654@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0105251457570.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Dawson Engler wrote:

> Boilerplate disclaimer:
>         - this is part of a one-time large batch of errors.  In the future,
>           we'll send out incremental bug reports along with a pointer to
>           the bug database on our website.

Personally, I'd like to see these every month or so, so
the bugs will go away within a month of their introduction.

Ideally, there never should be a large batch of any kind
of automatically checked bugs, except when a new check is
introduced...

OTOH, splitting them up may be a good idea, especially if
the email with the bug in it is CC'd to the person who is
listed in MAINTAINERS as taking care of that part of the
kernel ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbREOAow>; Mon, 14 May 2001 20:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbREOAom>; Mon, 14 May 2001 20:44:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13070 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262590AbREOAoX>; Mon, 14 May 2001 20:44:23 -0400
Date: Mon, 14 May 2001 21:44:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Jeff Golds <jgolds@resilience.com>
Cc: Wayne Whitney <whitney@math.berkeley.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 kernel reports wrong amount of physical memory
In-Reply-To: <3B006CC7.AAD065BA@resilience.com>
Message-ID: <Pine.LNX.4.33.0105142143190.18102-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Jeff Golds wrote:

> Ahh, it's totally obvious.  1 GB option = 890 MB, 4 GB option =
> 4GB.  Can I assume a linear relation and get 66.2 MB when I
> select the 64 MB option?

Where did you get the mythical "1GB" option?

Last I looked we had "off", "4GB" and "64GB" ;)

cheers,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


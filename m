Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131743AbRCORfR>; Thu, 15 Mar 2001 12:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131748AbRCORfH>; Thu, 15 Mar 2001 12:35:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:56068 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131743AbRCORe4>; Thu, 15 Mar 2001 12:34:56 -0500
Date: Thu, 15 Mar 2001 21:47:12 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Harrold <mharrold@cas.org>
Cc: "Mike A. Harris" <mharris@opensourceadvocate.org>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <200103151424.JAA12827@mah21awu.cas.org>
Message-ID: <Pine.LNX.4.33.0103152146570.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Mike Harrold wrote:

> 1) If a process uses swap space and then later (after being paged
>    into memory -- or even not) it completes, is killed, etc., is
>    the swap space reclaimed then?
>
> 2) If a process uses swap, is paged into memory, and is then swapped
>    out again, does it re-use the same swap as before?

Yes and yes.

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


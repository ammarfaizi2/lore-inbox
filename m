Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280594AbRKSSnj>; Mon, 19 Nov 2001 13:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280591AbRKSSna>; Mon, 19 Nov 2001 13:43:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:19974 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280593AbRKSSnS>; Mon, 19 Nov 2001 13:43:18 -0500
Date: Mon, 19 Nov 2001 16:43:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Erik Gustavsson <cyrano@algonet.se>, <linux-kernel@vger.kernel.org>
Subject: Re: Swap
In-Reply-To: <m1snba7hpw.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0111191642390.1491-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 2001, Eric W. Biederman wrote:

> > Is there a way to limit the size of the cache?
>
> Reasonable.  It looks like the use once heuristics are failing for your
> mp3 files.   Find out why that is happening and they should push the
> rest of your system into swap.

I bet they're getting mmap()d, like all mp3 programs seem to do  ;)

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/


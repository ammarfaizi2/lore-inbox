Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132682AbRDOOyM>; Sun, 15 Apr 2001 10:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132683AbRDOOyC>; Sun, 15 Apr 2001 10:54:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:55819 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132682AbRDOOxn>;
	Sun, 15 Apr 2001 10:53:43 -0400
Date: Sun, 15 Apr 2001 11:53:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: George Bonser <george@gator.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 stable when?
In-Reply-To: <CHEKKPICCNOGICGMDODJKENICLAA.george@gator.com>
Message-ID: <Pine.LNX.4.21.0104151151280.14442-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Apr 2001, George Bonser wrote:

> 2.4.4pre3 works, sorta, but is very "pumpy". The load avg will go up to
> about 60, then drop, then climb again, then drop. It will vary from very
> sluggish performance to snappy and back again to sluggish.

So it's stable ;))

> With 2.2 kernels I see something like this:
> 
>  00:48:00 up  4:51,  1 user,  load average: 0.00, 0.02, 0.06

*nod*

> Is there any information that would be helpful to the kernel
> developers that I might be able to provide or is this a known issue
> that is currently being worked out?

I never heard about this problem.  What would be helpful is to
send a few minutes' (a full 'load cycle'?) worth of output from
'vmstat 5' and some information about the configuration of the
machine.

It's possible I'll want more information later, but just the
vmstat output would be a good start.

If the data isn't too big, I'd appreciate it if you could also
CC linux-mm@kvack.org.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267883AbSIRRis>; Wed, 18 Sep 2002 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267928AbSIRRir>; Wed, 18 Sep 2002 13:38:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35848 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267883AbSIRRin>; Wed, 18 Sep 2002 13:38:43 -0400
Date: Wed, 18 Sep 2002 14:43:06 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Cort Dougan <cort@fsmlabs.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process()
 elimination, 2.5.35-BK
In-Reply-To: <20020918113551.A654@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.44L.0209181441430.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Cort Dougan wrote:

> It's also not a bad idea to sometimes say "Linux cannot do that".
> Trying to make the system do _everything_ will result in it doing many
> things very poorly.

That's been tried before, but for some reason people just won't
listen and Linux ended up running on non-x86 machines and even SMP.

I don't see any reason to rule out a fix for this problem in
principle, maybe somebody will come up with code that Linus does
like ?

cheers,

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/


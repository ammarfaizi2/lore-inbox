Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283743AbRK3SBv>; Fri, 30 Nov 2001 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283737AbRK3SBo>; Fri, 30 Nov 2001 13:01:44 -0500
Received: from ppp-97-16.29-151.libero.it ([151.29.16.97]:28666 "HELO
	blu.blu.i.prosa.it") by vger.kernel.org with SMTP
	id <S283738AbRK3SBe>; Fri, 30 Nov 2001 13:01:34 -0500
Date: Fri, 30 Nov 2001 18:54:00 +0100
From: antirez <antirez@invece.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130185359.Q31176@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07B820.4108246F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 30, 2001 at 11:47:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 11:47:28AM -0500, Jeff Garzik wrote:
> The security community has shown us time and again that public shaming
> is often the only way to motivate vendors into fixing security
> problems.  Yes, even BSD security guys do this :)

It's a bit different. Usually the security community uses it
when there isn't a way to fix the code (i.e. non-free code)
or when the maintaner of the code refused to fix the issue.
Also to "expose" the security problem isn't the same as
to flame.

While not a good idea, something like a long name
for a local var isn't a big problem like a completly
broken software with huge security holes used by milions of people
every day.

The quality of the code should be ensured in a different
way. If there is a standard coding-style you should either:

1) refuse to include broken code before the programmer fix it
2) fix it yourself before the inclusion

Flames aren't a good solution imho.

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF

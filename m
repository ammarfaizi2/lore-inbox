Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280956AbRK3SzB>; Fri, 30 Nov 2001 13:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280960AbRK3Syw>; Fri, 30 Nov 2001 13:54:52 -0500
Received: from ppp-97-16.29-151.libero.it ([151.29.16.97]:52730 "HELO
	blu.blu.i.prosa.it") by vger.kernel.org with SMTP
	id <S280956AbRK3Syo>; Fri, 30 Nov 2001 13:54:44 -0500
Date: Fri, 30 Nov 2001 19:47:11 +0100
From: antirez <antirez@invece.org>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue
Message-ID: <20011130194711.S31176@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <20011130185359.Q31176@blu> <3C07CDFB.7F1A9FFC@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07CDFB.7F1A9FFC@randomlogic.com>; from pgallen@randomlogic.com on Fri, Nov 30, 2001 at 10:20:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 10:20:43AM -0800, Paul G. Allen wrote:
> antirez wrote:
> A variable/function name should ALWAYS be descriptive of the
> variable/function purpose. If it takes a long name, so be it. At least
> the next guy looking at it will know what it is for.

I agree, but descriptive != long

for (mydearcountr = 0; mydearcounter < n; mydearcounter++)

and it was just an example. Read it as "bad coding style".

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF

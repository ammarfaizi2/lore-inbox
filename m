Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286372AbRLTVCp>; Thu, 20 Dec 2001 16:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286375AbRLTVC0>; Thu, 20 Dec 2001 16:02:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58755 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S286374AbRLTVCV> convert rfc822-to-8bit; Thu, 20 Dec 2001 16:02:21 -0500
Date: Thu, 20 Dec 2001 16:05:26 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <20011220203223.GO7414@vega.digitel2002.hu>
Message-ID: <Pine.LNX.3.95.1011220155155.8609A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, [iso-8859-2] Gábor Lénárt wrote:

> On Thu, Dec 20, 2001 at 01:52:13PM -0500, Eric S. Raymond wrote:
> > Steven Cole <scole@lanl.gov>:
> > > I see that in the very latest Configure.help version, 2.76,
> > > available at http://www.tuxedo.org/~esr/cml2/ Eric has decided to
> > > follow the following standard: IEC 60027-2, Second edition, 2000-11,
> > > Letter symbols to be used in electrical technology - Part 2:
> > > Telecommunications and electronics.  and has changed all the
> > > abbreviations for Kilobyte (KB) to KiB, Megabyte (MB) to MiB, etc,
> > > etc.
> 
> What? AFAIK 'K' means 1000 in SI. However since computers use binary
> numbers, the number (2^n) which was the most closer to 1000 was selected to
> be used as 'K' for indicating information amount, where n=10. [for decimal
> numbers 10^n (n=3) is used for 'K']. And so on with 'M', 'G' ... Sorry if
> I was wrong about this ...
> 

One of the many bad things about changing this kind of stuff is that
it doesn't even follow the rules, i.e., upper case is used for proper
names an/or where there could be a conflict between a previously-defined
abbreviation such as milliampere and megampere (mA, MA). Instead, most
everybody uses K for kilo and it's as absolutely incorrect as possible.
The existing symbols work by fiat. You can't make them "correct" by
following incorrect rules.

If we change anything......, we should define a new system of units,
PI, instead of SI. The basic unit is measurement is the Penguin. It is
abbreviated as p.

Powers of 2:

2 ^ 0  =  p    (1)
2 ^ 1  =  dp   dipenguin
2 ^ 2  =  qp   hepenguin
2 ^ 3  =  op   octpenguim
2 ^ 4  =  hp   hexpenguim
2 ^ 5  =  ddp  duodipenguin
2 ^ 6  =  oop  octoctpenguin
2 ^ 7  =  ohp  octohexpenguin
2 ^ 8  =  hhp  hexahexpenguin
2 ^ 9  =  dhhp duohexahexpenguin
2 ^ 10 =  kp   kilopenguin
2 ^ 20 =  mp   megapenguin
2 ^ 30 =  gp   gigapenguin 
...etc.

........ otherwise we should leave it alone!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
 Santa Claus is coming to town...
          He knows if you've been sleeping,
             He knows if you're awake;
          He knows if you've been bad or good,
             So he must be Attorney General Ashcroft.



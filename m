Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286362AbRLTUcx>; Thu, 20 Dec 2001 15:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286364AbRLTUcn>; Thu, 20 Dec 2001 15:32:43 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:14722 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S286362AbRLTUcb>; Thu, 20 Dec 2001 15:32:31 -0500
Date: Thu, 20 Dec 2001 21:32:23 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011220203223.GO7414@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <200112201721.KAA05522@tstac.esa.lanl.gov> <20011220135213.B18128@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20011220135213.B18128@thyrsus.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: vega Linux 2.4.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:52:13PM -0500, Eric S. Raymond wrote:
> Steven Cole <scole@lanl.gov>:
> > I see that in the very latest Configure.help version, 2.76,
> > available at http://www.tuxedo.org/~esr/cml2/ Eric has decided to
> > follow the following standard: IEC 60027-2, Second edition, 2000-11,
> > Letter symbols to be used in electrical technology - Part 2:
> > Telecommunications and electronics.  and has changed all the
> > abbreviations for Kilobyte (KB) to KiB, Megabyte (MB) to MiB, etc,
> > etc.

What? AFAIK 'K' means 1000 in SI. However since computers use binary
numbers, the number (2^n) which was the most closer to 1000 was selected to
be used as 'K' for indicating information amount, where n=10. [for decimal
numbers 10^n (n=3) is used for 'K']. And so on with 'M', 'G' ... Sorry if
I was wrong about this ...

- Gabor

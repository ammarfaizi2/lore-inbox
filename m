Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286540AbRLUUZD>; Fri, 21 Dec 2001 15:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLUUY4>; Fri, 21 Dec 2001 15:24:56 -0500
Received: from kaboom.dsl.xmission.com ([166.70.87.226]:47528 "EHLO
	mail.oobleck.net") by vger.kernel.org with ESMTP id <S285128AbRLUUYp>;
	Fri, 21 Dec 2001 15:24:45 -0500
Date: Fri, 21 Dec 2001 13:24:44 -0700 (MST)
From: Chris Ricker <kaboom@gatech.edu>
Reply-To: World Domination Now! <linux-kernel@vger.kernel.org>
To: World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <200112211937.fBLJbkSr021293@svr3.applink.net>
Message-ID: <Pine.LNX.4.33.0112211313160.30646-100000@verdande.oobleck.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Timothy Covell wrote:

> 
> On Friday 21 December 2001 13:12, David Weinehall wrote:
> [snip]
> 
> > Whatever the choice ends up being, KB is always incorrect, unless you
> > intend to specify some strange formula where the number of bytes (B)
> > combined with the temperature in Kelvin (K) has anything to do with
> > things.
> >
> >
> >
> > /David Weinehall
> 
> The way the metric prefixes work is that multiplicative prefixes are
> capitalized and divisional prefixes are in lower case.

Nonsense.  Some of what you're calling multiplicative prefixes (as if they
weren't *all* multiplicative ;-) are capitalized, and others are not.  kilo
(10^3) is k, hecto (10^2) is h, and deca (10^1) is da, for example.  See
<http://www.bipm.fr/enus/6_Publications/si/si-brochure.html> for the
official guidelines (page 23 if you read English, and page 28 if you read
French).

More relevant to the whole Configure.help discussion, if you want to
pedantic, official SI guidelines also state on the same page that:

"These SI prefixes refer strictly to powers of 10.  They should not be used 
to indicate powers of 2 (for example, one kilobit represents 1000 bits and 
not 1024 bits)."

later,
chris


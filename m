Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289558AbSAORFY>; Tue, 15 Jan 2002 12:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289989AbSAORFP>; Tue, 15 Jan 2002 12:05:15 -0500
Received: from dsl-64-130-65-177.telocity.com ([64.130.65.177]:39150 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S289558AbSAORFB>; Tue, 15 Jan 2002 12:05:01 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
	the elegant solution)
From: Thomas Duffy <Thomas.Duffy.99@alumni.brown.edu>
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Cc: Bruce Harada <bruce@ask.ne.jp>, esr@thyrsus.com,
        Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020115072958.A7900@pimlott.ne.mediaone.net>
In-Reply-To: <20020114125228.B14747@thyrsus.com>
	<20020114125508.A3358@twoflower.internal.do>
	<20020114135412.D17522@thyrsus.com>
	<20020114223042.ENDG28486.femail48.sdc1.sfba.home.com@there>
	<20020114173423.A23081@thyrsus.com>
	<20020115080218.7709cef7.bruce@ask.ne.jp> 
	<20020115072958.A7900@pimlott.ne.mediaone.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 09:04:16 -0800
Message-Id: <1011114263.1145.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 04:29, Andrew Pimlott wrote:

> - Building from source is good karma.
> 
> You might think these are trifles and < 1% cases.  My intuition
> tells me that they add up in the long run.  At least it's worth
> considering.

- Someday, a stupid government or court decides that there is a strict
separation between source and binary.  Source is protected speech, but
binaries are not.  Linux decides it wants a really fast DVD decryption
in the kernel, so it adds it in drivers.  But now, distro's cannot
compile and distribute a binary kernel package and the end user will
need to compile the source code in order to watch their DVD.

Why is it unrealistic for everybody to compile their kernel when they do
an install?  If it is rather automated, then it just becomes another
step on the progress bar.

-tduffy



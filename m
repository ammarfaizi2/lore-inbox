Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbRGSHPY>; Thu, 19 Jul 2001 03:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbRGSHPP>; Thu, 19 Jul 2001 03:15:15 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:43791 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S266982AbRGSHPJ>; Thu, 19 Jul 2001 03:15:09 -0400
Date: Thu, 19 Jul 2001 09:14:18 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Dan Podeanu <pdan@spiral.extreme.ro>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: menuconfig cannot change numbers in 2.4.6 
In-Reply-To: <Pine.LNX.4.33L2.0107190813580.13091-100000@spiral.extreme.ro>
Message-ID: <Pine.LNX.4.31.0107190912010.24235-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2001, Dan Podeanu wrote:

> On Thu, 19 Jul 2001, Keith Owens wrote:
>
> > On Wed, 18 Jul 2001 21:19:44 +0200 (CEST),
> > Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de> wrote:
> > >By make menuconfig I am unable to change e.g.
> > >CONFIG_AIC7XXX_RESET_DELAY_MS in a sane way: I can only add characters to
> > >the string. Was there a change or am I doing something wrong? There are no
> > >errors before...
> >
> > Works for me on 2.4.7-pre8.
> >
>
> Its the terminal thats messed up. Try CTRL-H instead of backspace.
>
No, this doesn't help, but thanks for the hints: it just doesn't work with
konsole's xterm XFree4.x.x mode. Strange enough that I didn't notice
anything odd in other apps...

Ciao,
					Roland


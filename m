Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283537AbRK3HcD>; Fri, 30 Nov 2001 02:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283536AbRK3Hby>; Fri, 30 Nov 2001 02:31:54 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:1411 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S283537AbRK3Hbo>; Fri, 30 Nov 2001 02:31:44 -0500
Date: Fri, 30 Nov 2001 08:31:40 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel File system Corruption related
Message-ID: <20011130083140.A17631@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <861yiho985.fsf@jeffrin@msservices.org> <20011129163709.A23980@cr213096-a.rchrd1.on.wave.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20011129163709.A23980@cr213096-a.rchrd1.on.wave.home.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: vega Linux 2.4.16 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 04:37:09PM -0500, Masoud wrote:
> Hi, 
> I am using 2.4.16 quite happily with a i810 chipset. Besides, 
> i810 chipset series are for at least Celeron/Pentium II/Pentium III's.
> can you give more details? did the system cleanly shutdown when you ran
> "init 0"?
> cheers,
> Masoud

Hi!

It works for us (TM) on several i810 based PCs. However XFree 4.1.0
sometimes (about once a week, mainly when you try to use XVideo extension)
XServer quites with "lock up" message but Imho it's not a kernel related
problem (no oops, or something similar).

- Gabor
y

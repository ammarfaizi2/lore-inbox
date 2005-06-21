Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFUL3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFUL3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVFUL3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:29:22 -0400
Received: from alog0132.analogic.com ([208.224.220.147]:44986 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261205AbVFULSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:18:11 -0400
Date: Tue, 21 Jun 2005 07:17:55 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dave Jones <davej@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
In-Reply-To: <20050621111301.GA592@redhat.com>
Message-ID: <Pine.LNX.4.61.0506210714400.9115@chaos.analogic.com>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com>
 <20050621003203.GB28908@redhat.com> <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com>
 <20050621111301.GA592@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005, Dave Jones wrote:

> On Tue, Jun 21, 2005 at 06:32:32AM -0400, Richard B. Johnson wrote:
>
> > Bullshit. The source is available to anybody who wants it.
>
> Great. Then please explain why you pull off this kind of crap..
> (DataLink/license.c)
>

Because it's true.


> //
> //   This program may be distributed under the GNU Public License
> //   version 2, as published by the Free Software Foundation, Inc.,
> //   59 Temple Place, Suite 330 Boston, MA, 02111.
> //
> //
> #ifndef __KERNEL__
> #define __KERNEL__
> #endif
> #ifndef MODULE
> #define MODULE
> #endif
> #include <linux/module.h>
> #if defined(MODULE_LICENSE)
> MODULE_LICENSE("GPL\0 They won't allow GPL/BSD anymore!");
> #endif
>
> > It's worthless without fiber-optic data-link boards that it
> > supports.
>
> That's not the point. I've not had the hardware for 99% of
> the drivers I've hacked on over the last 10 years.
>
> btw, I realise you're trying to make a point, but you don't
> need to send any further 900K tarballs to the list. An URL
> would suffice.
>
> 		Dave
>

The company doesn't allow any access from the outside world. You
can get only what I can send you and I do it at my peril because
the IT Nazis might catch me.

>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbTBCSIr>; Mon, 3 Feb 2003 13:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBCSIr>; Mon, 3 Feb 2003 13:08:47 -0500
Received: from [65.39.167.210] ([65.39.167.210]:4868 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S266938AbTBCSIq>;
	Mon, 3 Feb 2003 13:08:46 -0500
Date: Mon, 3 Feb 2003 13:18:18 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Jeff Garzik <jgarzik@pobox.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: a code slush for 2.5?
In-Reply-To: <3E3E21D3.1090402@pobox.com>
Message-ID: <Pine.LNX.4.44.0302031316040.4263-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Jeff Garzik wrote:

> Specific areas I think deserve attention before "nothing but bug fixes"
> includes a lot of driver implementation and testing for the driver
> model.  Pat's given us some cool stuff... that isn't used very much so
> far.  There are some key implementation decisions in that area that need
> to be made, before a lot of that can be used, too.  Power Management is
> another area.  That sorta fell by the wayside, IMO, but _is_ doable
> given the current infrastructure that 2.5 now has.  klibc is yet another
> thing that needs tackling.
>
> Maybe I am coming from a "driver guy" bias, but it seems like calling a
> code freeze is premature.  I know everybody's chomping at the bit for
> 2.6 to be released, already, gosh darn it.  But please consider this
> pause, as well.
>
> So, if I had to make the proposal concrete, I would propose:
> 	"code slush" effective immediately
> 	code freeze, Easter holiday (April 19?)
>
> Comments/curses?

It would be wise if a freeze was delayed until after at least IDE and
console switching both work reliably with preempt enabled.


	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292093AbSBTRcO>; Wed, 20 Feb 2002 12:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292091AbSBTRcI>; Wed, 20 Feb 2002 12:32:08 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8696
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292195AbSBTRbw>; Wed, 20 Feb 2002 12:31:52 -0500
Date: Wed, 20 Feb 2002 09:32:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020220173216.GC15228@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Ville Herva <vherva@niksula.cs.hut.fi>,
	george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020220172052.GA15228@matchmail.com> <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0202201423170.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 02:24:42PM -0300, Rik van Riel wrote:
> On Wed, 20 Feb 2002, Mike Fedyk wrote:
> > On Wed, Feb 20, 2002 at 01:36:02PM +0200, Ville Herva wrote:
> > > asm-ia64/param.h:# define HZ    1024
> > > asm-x86_64/param.h:#define HZ 100
> >
> > What's the difference between these two architectures?  Intel 64bit
> > processor and AMD's upcoming 64bit processor?
> 
> One is a 64 bit extension to a modern superscalar
> architecture which has descended from 8 bit machines
> over the ages.
> 
> The other is a 3-issue VLIW follow-up to the 2-issue
> VLIW i860.
>

Oh, I didn't know that processor was used for more than printers, raid
controllers, and similar.

Anyone have an URL for this arch?

> cheers,
> 
> Rik

Thanks,

Mike

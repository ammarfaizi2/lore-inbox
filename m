Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292131AbSBTRpe>; Wed, 20 Feb 2002 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292133AbSBTRpW>; Wed, 20 Feb 2002 12:45:22 -0500
Received: from zeus.kernel.org ([204.152.189.113]:31704 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S292108AbSBTRpE>;
	Wed, 20 Feb 2002 12:45:04 -0500
Date: Wed, 20 Feb 2002 14:39:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <20020220173216.GC15228@matchmail.com>
Message-ID: <Pine.LNX.4.44L.0202201439290.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Mike Fedyk wrote:
> On Wed, Feb 20, 2002 at 02:24:42PM -0300, Rik van Riel wrote:
> > On Wed, 20 Feb 2002, Mike Fedyk wrote:
> > > On Wed, Feb 20, 2002 at 01:36:02PM +0200, Ville Herva wrote:
> > > > asm-ia64/param.h:# define HZ    1024
> > > > asm-x86_64/param.h:#define HZ 100
> > >
> > > What's the difference between these two architectures?  Intel 64bit
> > > processor and AMD's upcoming 64bit processor?
> >
> > One is a 64 bit extension to a modern superscalar
> > architecture which has descended from 8 bit machines
> > over the ages.
> >
> > The other is a 3-issue VLIW follow-up to the 2-issue
> > VLIW i860.
>
> Oh, I didn't know that processor was used for more than printers, raid
> controllers, and similar.
>
> Anyone have an URL for this arch?

Intel has it well hidden from their front page, but you
can find info here:

http://www.intel.com/itanium/index.htm

cheers,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/


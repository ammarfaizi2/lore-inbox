Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280658AbRKFWm6>; Tue, 6 Nov 2001 17:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280653AbRKFWmu>; Tue, 6 Nov 2001 17:42:50 -0500
Received: from codepoet.org ([166.70.14.212]:18475 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280655AbRKFWmj>;
	Tue, 6 Nov 2001 17:42:39 -0500
Date: Tue, 6 Nov 2001 15:42:40 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011106154240.A32249@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl> <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva> <20011106152826.C31923@codepoet.org> <20011106233349.A26236@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011106233349.A26236@lug-owl.de>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 06, 2001 at 11:33:49PM +0100, Jan-Benedict Glaw wrote:
> On Tue, 2001-11-06 15:28:26 -0700, Erik Andersen <andersen@codepoet.org>
> wrote in message <20011106152826.C31923@codepoet.org>:
> > On Tue Nov 06, 2001 at 07:24:13PM -0200, Rik van Riel wrote:
> > > PROCESSOR=0
> > > VENDOR_ID=GenuineIntel
> > > CPU_FAMILY=6
> > > MODEL=6
> > > MODEL_NAME="Celeron (Mendocino)"
> > > .....
> 
> PROCESSOR=1
> ...
> 
> > > . /proc/cpuinfo
> > 
> > I think we have a winner!  If we could establish this 
> > as policy that would be _sweet_!
> 
> What do you expect on a SMP system?

How about something like:
NUMBER_CPUS=8
VENDOR_ID_0=GenuineIntel
CPU_FAMILY_0=6
MODEL_0=6
MODEL_NAME_0="Celeron (Mendocino)"
...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSAOXNh>; Tue, 15 Jan 2002 18:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289737AbSAOXN2>; Tue, 15 Jan 2002 18:13:28 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:61623 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S289724AbSAOXNU>; Tue, 15 Jan 2002 18:13:20 -0500
Date: Wed, 16 Jan 2002 10:13:14 +1100
From: CaT <cat@zip.com.au>
To: David Weinehall <tao@acc.umu.se>
Cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020115231313.GA5211@zip.com.au>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <20020115225140.GZ5211@zip.com.au> <20020116000057.D5235@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020116000057.D5235@khan.acc.umu.se>
User-Agent: Mutt/1.3.25i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 12:00:57AM +0100, David Weinehall wrote:
> On Wed, Jan 16, 2002 at 09:51:40AM +1100, CaT wrote:
> > On Tue, Jan 15, 2002 at 05:01:11PM +0100, Olaf Dietsche wrote:
> > > Hi,
> > > 
> > > this is a new file system to control access to system resources.
> > > Currently it controls access to inet_bind() with ports < 1024 only.
> > 
> > Woo. :) I've been thinking of making something like this my first
> > kernel project but you beat me to it. Drat. :)
> 
> I guess it's time to revise the old Unix saying "everything is a file"
> to "everything is a file system" =)

Well it is on a mac (more or less). Resource forks are a mini
filesystem. :)

-- 
SOCCER PLAYER IN GENITAL-BITING SCANDAL  ---  "It was something between
friends that I thought would have no importance until this morning when
I got up and saw all  the commotion in the news,"  Gallardo told a news
conference. "It stunned me."
Reyes told Marca that he had "felt a slight pinch."

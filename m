Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289775AbSAOXBa>; Tue, 15 Jan 2002 18:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289730AbSAOXBT>; Tue, 15 Jan 2002 18:01:19 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:19381 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289729AbSAOXBL>;
	Tue, 15 Jan 2002 18:01:11 -0500
Date: Wed, 16 Jan 2002 00:00:57 +0100
From: David Weinehall <tao@acc.umu.se>
To: CaT <cat@zip.com.au>
Cc: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][PATCH] New fs to control access to system resources
Message-ID: <20020116000057.D5235@khan.acc.umu.se>
In-Reply-To: <87k7uj61tk.fsf@tigram.bogus.local> <20020115225140.GZ5211@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020115225140.GZ5211@zip.com.au>; from cat@zip.com.au on Wed, Jan 16, 2002 at 09:51:40AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 09:51:40AM +1100, CaT wrote:
> On Tue, Jan 15, 2002 at 05:01:11PM +0100, Olaf Dietsche wrote:
> > Hi,
> > 
> > this is a new file system to control access to system resources.
> > Currently it controls access to inet_bind() with ports < 1024 only.
> 
> Woo. :) I've been thinking of making something like this my first
> kernel project but you beat me to it. Drat. :)

I guess it's time to revise the old Unix saying "everything is a file"
to "everything is a file system" =)


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288141AbSAHPlC>; Tue, 8 Jan 2002 10:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288135AbSAHPkx>; Tue, 8 Jan 2002 10:40:53 -0500
Received: from gate.mesa.nl ([194.151.5.70]:44811 "EHLO joshua.mesa.nl")
	by vger.kernel.org with ESMTP id <S288130AbSAHPkk>;
	Tue, 8 Jan 2002 10:40:40 -0500
Date: Tue, 8 Jan 2002 16:40:35 +0100
From: "Marcel J.E. Mol" <marcel@mesa.nl>
To: Dan Chen <crimsun@email.unc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE Patch (fwd)
Message-ID: <20020108164035.D22535@joshua.mesa.nl>
Reply-To: marcel@mesa.nl
In-Reply-To: <20020108150346.GA24479@infodancer.org> <Pine.LNX.4.10.10201080709060.991-100000@master.linux-ide.org> <20020108152736.GB347@opeth.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020108152736.GB347@opeth.ath.cx>; from crimsun@email.unc.edu on Tue, Jan 08, 2002 at 10:27:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the -ac tree had the patch in until at least 2.4.13-ac,
which I run on my laptop because it is the latest kernel
that flushes the ide-drive writecache at shutdown.
Before that I had regular filesystem corruptions...

-Marcel

On Tue, Jan 08, 2002 at 10:27:36AM -0500, Dan Chen wrote:
> On Tue, Jan 08, 2002 at 07:12:14AM -0800, Andre Hedrick wrote:
> > Thanks for the feedback, but lkml needs it or it will not be adopted.
> > I know the driver is stable and effectively perfect in operations.
> > So I do not understand the total ignore I receive about it.
> 
> Andre's ide.2.4.16.12102001.patch works great here. I strongly recommend
> it be considered for 2.5 if not also for 2.4.
> 
> -- 
> Dan Chen                 crimsun@email.unc.edu
> GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc



-- 
     ======--------         Marcel J.E. Mol                MESA Consulting B.V.
    =======---------        ph. +31-(0)6-54724868          P.O. Box 112
    =======---------        marcel@mesa.nl                 2630 AC  Nootdorp
__==== www.mesa.nl ---____U_n_i_x______I_n_t_e_r_n_e_t____ The Netherlands ____
 They couldn't think of a number,           Linux user 1148  --  counter.li.org
    so they gave me a name!  -- Rupert Hine  --  www.ruperthine.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280186AbRK1TRt>; Wed, 28 Nov 2001 14:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280153AbRK1TRm>; Wed, 28 Nov 2001 14:17:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12022
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S280307AbRK1TRZ>; Wed, 28 Nov 2001 14:17:25 -0500
Date: Wed, 28 Nov 2001 11:17:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Dan Kegel <dank@kegel.com>, Fran?ois Cami <stilgar2k@wanadoo.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
Message-ID: <20011128111718.A513@mikef-linux.matchmail.com>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Dan Kegel <dank@kegel.com>, Fran?ois Cami <stilgar2k@wanadoo.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <dank@kegel.com> <3C03CFA7.3E824AE7@kegel.com> <200111281623.fASGN7lC015061@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111281623.fASGN7lC015061@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2001 at 01:23:07PM -0300, Horst von Brand wrote:
> Dan Kegel <dank@kegel.com> said:
> > Fran?ois Cami wrote:
> 
> [...]
> 
> > > That said, I think the week long delay is a *good* idea.
> 
> > It's the key to avoiding bad releases.
> 
> Yep. Specially when new 2.5.X-preY or 2.5.X are generated at a rate of 2 or
> 3 a week. Look at the history of the kernel. This would only create even
> _more_ pressure to get new patches in, and that is bad.

2.5 doesn't have releases, just snapshots of the development.

> 
> When a freeze (or slush) is decreed at the very end, it makes sense.
> Remember that a large part of the success of Linux is due to "Release
> early, release often".

Remember we are talking about 2.4, not 2.5.  Having more time between
releases gives more time to test the pre releases.  The point it to have
good point (not like 2.4.11, 12, 14, or 15) releases for what is supposed to
be *stable*.

Release 50 -pre kernels for 2.4, but make sure that the next release has had a
chance to stabalize with the new changes.

MF

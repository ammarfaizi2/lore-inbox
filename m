Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSLJTHk>; Tue, 10 Dec 2002 14:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLJTHk>; Tue, 10 Dec 2002 14:07:40 -0500
Received: from AMarseille-201-1-4-202.abo.wanadoo.fr ([217.128.74.202]:3696
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261582AbSLJTHi>; Tue, 10 Dec 2002 14:07:38 -0500
Subject: Re: Linux 2.5.51
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Stian Jordet <liste@jordet.nu>, Allan Duncan <allan.d@bigpond.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0212101016280.2617-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0212101016280.2617-100000@maxwell.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Dec 2002 20:18:56 +0100
Message-Id: <1039547936.538.5.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:16, James Simmons wrote:
> 
> > > I can take care of radeon's. Did you already used my updated version
> > > from the PPC tree ?
> >
> > Will the Radeon fbdev driver work with all Radeons (for instance a
> > Radeon 9700 Pro)?
> 
> Yes I saw support for this card :-)

Well, I'm not sure it quite works yet. Maybe unaccelerated, but anyway,
my version of radeonfb for 2.5 isn't accelerated yet anyway. I'll work
on that (or Ani will) now that the API is stable enough.

Ben.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282352AbRK0SPR>; Tue, 27 Nov 2001 13:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282218AbRK0SPI>; Tue, 27 Nov 2001 13:15:08 -0500
Received: from adsl-64-171-188-191.dsl.snfc21.pacbell.net ([64.171.188.191]:47366
	"HELO luban.org") by vger.kernel.org with SMTP id <S282207AbRK0SPA>;
	Tue, 27 Nov 2001 13:15:00 -0500
Message-ID: <3C03D7E2.66A892F2@Luban.org>
Date: Tue, 27 Nov 2001 10:13:54 -0800
From: Vitaly Luban <Vitaly@Luban.org>
Organization: Vitaly's Home
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Kegel <dank@kegel.com>
CC: =?iso-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <3C03CC6C.DD03CDDE@kegel.com> <3C03CF2A.5070307@wanadoo.fr> <3C03CFA7.3E824AE7@kegel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:

> François Cami wrote:
> >
> > Dan Kegel wrote:
> >
> > > 2.4.x should continue to use -preY.
> > > There's no need for a -rcY as some have suggested.
> > > All we need to do to avoid messes like the 2.4.15 debacle
> > > is to insist that a 2.4.X-preY should not be
> > > released as final 2.4.X until the pre's been out for a week,
> > > and there should never be any changes introduced into a final
> > > that didn't cook for a week as a pre.
> >
> > I don't see the difference between a -rc that has cooked for a week,
> > and a -pre that has cooked for a week, except that -rc sounds more
> > like "this is *maybe* the next stable kernel", whereas -pre still
> > sounds "beta".
>
> The difference between "this is *maybe* the next stable kernel"
> and "just another beta" is very slippery.  I don't object
> to the -rc idea, but I don't think it's as valuable as all that.
>

IMHO, -rc is just one extra unnecessary entity and may bring
only some confusion to newbies & extra work for maintaner.

Cheers,
    Vitaly.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbTABJtd>; Thu, 2 Jan 2003 04:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTABJtd>; Thu, 2 Jan 2003 04:49:33 -0500
Received: from vaak.stack.nl ([131.155.140.140]:65040 "EHLO mailhost.stack.nl")
	by vger.kernel.org with ESMTP id <S261305AbTABJtc>;
	Thu, 2 Jan 2003 04:49:32 -0500
Date: Thu, 2 Jan 2003 10:57:54 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Mark Rutherford <mark@justirc.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.50L.0301011931240.2429-100000@imladris.surriel.com>
Message-ID: <20030102104612.V63864-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Rik van Riel wrote:

> On Wed, 1 Jan 2003, Mark Rutherford wrote:
>
> > I would LOVE to see Nvidia open source,
> > We cannot force our ideas on a company, all they will do is turn and walk away.
> > We can show them our way, if they like it, good. if not, we tried.
>
> Nvidia is a smart company, otherwise they wouldn't be in
> business today.  I'm sure they'll switch to the GPL only
> once it will be in their advantage to do so and no sooner.
>
> When would it be an advantage for them ?
>
> The moment there is a GPL graphics library (at the right
> system level, of course) that's so good Nvidia won't be
> able to resist using that library could be such a moment.
>
> A new project for Hell.Surfers ? ;)

Mr Surfers has already showed up at the KGI development team, but as I
think his attitude doesn't quite fit in the team, I have not encouraged
him to help.

But yes, there is a GPL graphics kernel module / library (KGI & GGI) that
should run on linux and any BSD real soon now. The Radeon and Matrox
drivers are in place, already. The 3D accelleration framework is in place,
but the GGI GL implementation is not yet existing.

For those who want to take a look: the website (www.kgi-project.org) is
outdated, we lost contact with the maintainer :( Please take a look at the
kgi-wip project at sourceforge (CVS only) and at irc.openprojects.net #kgi

Jos


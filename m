Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSA3Bqo>; Tue, 29 Jan 2002 20:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA3Bqe>; Tue, 29 Jan 2002 20:46:34 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59333 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S287908AbSA3BqT>;
	Tue, 29 Jan 2002 20:46:19 -0500
Date: Tue, 29 Jan 2002 20:46:17 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Rob Landley <landley@trommello.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@transmeta.com>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129204617.A16318@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com> <m1wuy1cn0w.fsf@frodo.biederman.org> <E16Vi1x-0000Aw-00@starship.berlin> <200201300131.g0U1VsU22963@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201300131.g0U1VsU22963@snark.thyrsus.com>; from landley@trommello.org on Tue, Jan 29, 2002 at 08:33:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 08:33:03PM -0500, Rob Landley wrote:
> > Yes, we should cc our patches to a patchbot:
> >
> >   patches-2.5@kernel.org -> goes to linus
> >   patches-2.4@kernel.org -> goes to marcello
> >   patches-usb@kernel.org -> goes to gregkh, regardless of 2.4/2.5
> >   etc.
> >
> > The vast sea of eyeballs will do the rest.  A web interface would be a nice
> > bonus, but 'patch sent and seen to be sent, to whom, when, what, why' is
> > the essential ingredient.
> 
> And of course there's not much point in having patches go to that list that 
> AREN'T public

If mail sent to the above addresses is not public somehow, the idea
is a non-starter.


> Of course this still doesn't address the problem of patches going stale if 
> they're not applied for a version or two and something else that goes in 
> breaks them...

If you really want to be a patch penguin then.... just do it.

You don't need specific permission to pick up, update, and maintain
patches that don't make it into the Linus tree on the first try.

	Jeff





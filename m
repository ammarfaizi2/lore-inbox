Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSBCXg3>; Sun, 3 Feb 2002 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287872AbSBCXgV>; Sun, 3 Feb 2002 18:36:21 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:401 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287868AbSBCXgL>;
	Sun, 3 Feb 2002 18:36:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Peter C. Norton" <spacey@lenin.nu>
Subject: Re: Wanted: Volunteer to code a Patchbot
Date: Mon, 4 Feb 2002 00:40:16 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
        smurf@osdl.org, jsievert@osdl.org, wookie@osdl.org
In-Reply-To: <Pine.LNX.4.33.0201300934500.800-100000@segfault.osdlab.org> <E16VzYC-0000Gt-00@starship.berlin> <20020203185416.GD3039@lenin.nu>
In-Reply-To: <20020203185416.GD3039@lenin.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16XWF7-0003JD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 3, 2002 07:54 pm, Peter C. Norton wrote:
> BTW, in the interest of not re-inventing the wheel, and I'm sorry if this
> has been mentioned already in this thread, but for confirmations,
> whitelist/blacklist stuff for the patchbots take a look at tmda, at
> http://tmda.sourceforge.net.

Thanks for this, but whitelist/blacklist is just one aspect of the patchbot, 
and far from the most important aspect.  I think tmda might have a little 
trouble validating a patch against a kernel tree, for example

In Python the white/blacklist handling is trivial anyway.  A workable 
confirmation feature was coded in a couple of hours by the guys (Rasmus and 
Kalle) working on the bot, and it does exactly what we want it to.  Progress 
marches on, Python rocks.  (So do Rasmus and Kalle.)

-- 
Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWBAN7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWBAN7e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 08:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbWBAN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 08:59:34 -0500
Received: from thunk.org ([69.25.196.29]:22215 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161054AbWBAN7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 08:59:32 -0500
Date: Wed, 1 Feb 2006 08:59:14 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 -- PLEA FOR SANITY
Message-ID: <20060201135913.GA7082@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	Chase Venters <chase.venters@clientec.com>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
	Patrick McLean <pmclean@cs.ubishops.ca>,
	Stephen Hemminger <shemminger@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <1138387136.26811.8.camel@localhost> <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain> <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com> <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <1138751851.10316.32.camel@localhost.localdomain> <20060201100127.GA13543@bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201100127.GA13543@bitwizard.nl>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let's give this thread a rest, OK?

Whether or not Linux is licensed under the GPLv2 only or not is
ultimately a matter for the lawyers.

The one big problem I see with the GPLv3 effort is given the
additional restrictions regarding DRM, it doesn't seem to clear to me
whether a project which has even a single line of GPLv2-only code can
accept GPLv3 code. That is, GPLv3 is designed to be compatible with
more licenses, but that doesn't matter of GPLv2 isn't compatible with
GPLv3.  If that is the case, if only a _single_ person (like Rogier)
has I want GPLv2-only, the whole project is can't use any GPLv3 code
unless they are willing to track down and rewrite all of the code
written by that person or persons.

If that is true (and again, at the end of the day lawyers or more
importantly, a judge is going to have to make that call, not debating
technologists) it's hard to see the GPLv3 making any headway.

						- Ted

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290595AbSA3VC2>; Wed, 30 Jan 2002 16:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290594AbSA3VCS>; Wed, 30 Jan 2002 16:02:18 -0500
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:57492 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S290593AbSA3VCN>; Wed, 30 Jan 2002 16:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Matthew D. Pitts" <mpitts@suite224.net>,
        "Chris Ricker" <kaboom@gatech.edu>,
        "Linus Torvalds" <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Wed, 30 Jan 2002 16:03:22 -0500
X-Mailer: KMail [version 1.3.1]
Cc: "World Domination Now!" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0201291938530.26901-100000@verdande.oobleck.net> <001601c1a98c$9681f760$dcf583d0@pcs586>
In-Reply-To: <001601c1a98c$9681f760$dcf583d0@pcs586>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020130210212.ZYOS23516.femail25.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 January 2002 07:49 am, Matthew D. Pitts wrote:
> Chris,
>
> Thank you for saying this... I have things I would like do/add to the
> kernel and I am not sure who to send them to.

No, if you're not a maintainer then you still send them to the maintainer in 
the MAINTAINERS file.

The interesting question is, who does THAT maintainer send them to.  (We seem 
to be heading for a four-tiered system, with Linus at the top, a dozen or so 
lieutenants under him, and then the specific maintainers under them.  With 
individual developers submitting patches being the fourth tier.  Patches go 
from developer, to maintainer, to lieutenant, to linus.)

This doesn't sound like a bad thing for scalability reasons, and should also 
help address the "I sent my patch directly to linus a dozen times and I 
didn't hear back" problem.

The problem right now is a lot of the maintainers don't seem to know who 
their corresponding lieutenant is.  We're still waiting for clarification 
from Linus...


> Also, is there presently a maintainer for Supermount? If not, I would be
> willing to pick it up for 2.5.x, as it is one of the things I want to work
> on.

I didn't spot one in MAINTAINERS.  The email at the top of "mount.h" says:

> * Author:  Marco van Wieringen <mvw@planets.elm.net>

So that might be a good person to ask.  Of course who knows how old that 
email address is... :)

> Matthew D. Pitts

Rob

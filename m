Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVBIHG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVBIHG5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 02:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVBIHG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 02:06:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261797AbVBIHGb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 02:06:31 -0500
To: lm@bitmover.com (Larry McVoy)
Cc: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050204160631.GB26748@bitmover.com>
	<20050204170306.GB3467@crusoe.alcove-fr>
	<20050204183922.GC27707@bitmover.com>
	<20050204200507.GE5028@deep-space-9.dsnet>
	<20050204201157.GN27707@bitmover.com>
	<20050204214015.GF5028@deep-space-9.dsnet>
	<20050204233153.GA28731@electric-eye.fr.zoreil.com>
	<20050205193848.GH5028@deep-space-9.dsnet>
	<20050205233841.GA20875@bitmover.com>
	<20050208154343.GH3537@crusoe.alcove-fr>
	<20050208155845.GB14505@bitmover.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 09 Feb 2005 05:06:02 -0200
In-Reply-To: <20050208155845.GB14505@bitmover.com>
Message-ID: <ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb  8, 2005, lm@bitmover.com (Larry McVoy) wrote:

> I think you are dreaming.  You've gone from wanting enough information
> to supposedly debug your source tree to being explicit about wanting to
> recreate the entire BK history in a different system.

> The answer is no, that's a clear violation of the license.

So you've somehow managed to trick most kernel developers into
granting you power over not only the BK history, in such a way that
anyone willing to extract all the information available from the BK
repository and share it with others is forbidden from doing so by the
license?

> I'm quite unhappy you keep asking for this, it forces me into the
> position of being the bad guy.  You need to understand that we can
> only take on so much risk and giving you BK for free was a huge amount
> of risk.

I'd much rather you didn't ``give´´ it at all, then people wouldn't be
locked into it, and the community might have come up with something as
efficient earlier with the extra push.  Now we're faced with choices
such as keeping on with a presumably technically-good but non-Free
software, or switching to a Free and hopefully as-good software and
losing history.  Clever trick, indeed!

> Giving you BK, and the right to use it to create a different
> system, and/or the right to use the BK metadata to create a different
> system is way too much risk.

Is it even legal to attempt to stop someone from sharing information
that is not owned by you?  Or did you get to own all of the metadata
in the repository?

> I don't come here every month and ask for the GPL to be removed from
> some driver, that's essentially what you are doing

I don't think so.  What he's doing is more along the lines of `hey,
this allegedly-GPLed driver contains a piece of binary firmware whose
source code is not there, could we either replace it with actual GPLed
code or remove the driver?

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

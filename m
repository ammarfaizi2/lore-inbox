Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCOLmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUCOLmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:42:10 -0500
Received: from codepoet.org ([166.70.99.138]:32911 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S262266AbUCOLmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:42:06 -0500
Date: Mon, 15 Mar 2004 04:41:42 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK/Web improvements (includes patch server)
Message-ID: <20040315114142.GA22039@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <200403150616.i2F6Gu2Z030020@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403150616.i2F6Gu2Z030020@work.bitmover.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Mar 14, 2004 at 10:16:56PM -0800, Larry McVoy wrote:
> I've made a few changes to the BK/Web service on BK/Bits.  There are some
> cosmetic changes but the substantial changes are as follows:
> 
>     - Traditional diff -Nur style patches served as text/plain.  You can 
>       now wget your favorite patch.

Hey thats cool, I know I will use this often to slurp down
patches of interest.

    <obligitory request for yet more stuff which is
    almost certain to piss you off since you just
    gave me yet-another-something-for-free>

I'm curious if you might consider adding a diff -Nur style
patch vs the last tagged version?  I often go to:
    http://www.kernel.org/pub/linux/kernel/v2.4/testing/cset/
and
    http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

to obtain this sortof a patch, for example when I want to submit
a patch that is relevant to the current kernel tree, rather than
1000 patches behind.  Sadly, these are often rather out of touch
with reality.  Check out for example the 2.4 one, which has been
stuck since March 8th.   :-(

Right now I can go to, for example:
    http://linux.bkbits.net:8080/linux-2.4/ChangeSet@1.1326..?nav=index.html|tags
and see the list of patches, and thanks to your latest update, I
can now click on each patch one-by-one to suck down a diff.  I
would sure love to be able to obtain the lot as cumulative patch
of everything after the last tagged version.

I do not know if that is something you might consider, if doing
so suites your business model, if doing so would make
unreasonable demands on your donated bandwidth, cpu power, etc,
etc, etc.  But such a thing would certainly come in handy, if you
felt so inclined.

Of course, an alternative solution would be for someone to fix
the kernel.org testing/cset/ scripts to not get wedged...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbTCPWf7>; Sun, 16 Mar 2003 17:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262775AbTCPWf7>; Sun, 16 Mar 2003 17:35:59 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:62652 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262759AbTCPWf6>;
	Sun, 16 Mar 2003 17:35:58 -0500
Date: Sun, 16 Mar 2003 23:46:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Shawn <core@enodev.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: constant Bitkeeper bitching
Message-ID: <20030316224643.GB1252@dualathlon.random>
References: <1047837820.3966.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047837820.3966.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 12:03:40PM -0600, Shawn wrote:
> [..] You had
> patches, folks... [..]

I agree with the rest but note that the above argument is silly too.
Patches are missing a great deal of info. bitkeeper is more useful for a
reason. Until today we had an information-loss problem, that was fixed
only for a restricted number of people for the last year, so it was very
far from a solution from my point of view. Today thanks to the kernel
CVS that Larry thankfully provided, IMHO this is finally solved and I
greatly appreciate that.

Of course if you don't develop the kernel you can live fine with
monolithic undocumented patches, you're not going to audit those diffs
anyways, do you? Few people will appreciate the difference between
patches and bk, but for developers having the finer granularity helps a
lot, so saying "go back to patches" is a no-way.  Just try to extract
stuff from the -ac tree and you get the idea, I'm stunned how can Alan
submit stuff to Marcelo and Linus w/o major pain and leftovers (ok, some
are driver changes and they're easy to extract, but not everything is
that simple and self contained).

Andrea

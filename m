Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290891AbSBLKCt>; Tue, 12 Feb 2002 05:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290913AbSBLKCk>; Tue, 12 Feb 2002 05:02:40 -0500
Received: from adsl-203-134.38-151.net24.it ([151.38.134.203]:4086 "EHLO
	morgana.systemy.it") by vger.kernel.org with ESMTP
	id <S290891AbSBLKCZ>; Tue, 12 Feb 2002 05:02:25 -0500
Date: Tue, 12 Feb 2002 11:01:09 +0100
From: Alessandro Rubini <rubini@gnu.org>
To: pasky@pasky.ji.cz, linuxconsole-dev@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, gpm@lists.linux.it, salvador@inti.gov.ar,
        jsimmons@transvirtual.com
Subject: Re: [gpm]Reworking the selection API and moving it to userspace (gpm)?
Message-ID: <20020212110109.A20350@morgana.systemy.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Free Lance in Pavia, Italy.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 6th, Petr Baudis:
> [...] However, James Simmons said that he will be working on
> this for 2.5 and move it to userspace completely, reworking gpm.

That would be great. We (gpm list) have been talking about it a few
years ago, but Ian Zimmerman reported a problem with mapping glyphs to
keyboard input: there was no mean (at least back then) to pass the
complete mapping from the kernel to user space.  Sure doing it for the
trivial mapping is trivial, and I think it would be an interesting
experiment.  I was even thinking to have a try some time ago, when I
was the gpm maintainer.

> I would like to ask if there's any movement in this issue. I would
> be even willing to help, if possible :).

Please get on the gpm mailing list (gpm@lists.linux.it) and let's put
together an implementation.

Best
/alessandro

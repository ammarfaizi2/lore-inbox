Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265028AbUEYSh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbUEYSh7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUEYSh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:37:59 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:34179 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265028AbUEYSh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:37:58 -0400
Date: Tue, 25 May 2004 14:06:28 -0400
From: Ben Collins <bcollins@debian.org>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040525180628.GJ1286@phunnypharm.org>
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <20040525131139.GW1286@phunnypharm.org> <Pine.LNX.4.58.0405251012260.9951@ppc970.osdl.org> <20040525171805.GG1286@phunnypharm.org> <20040525180225.GA2668@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525180225.GA2668@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Dave Jones <davej@redhat.com>
> Spotted-by: Joe Hacker <joe@scoblows.com>
> 
> As asking submitters to sign off on modified versions
> of their patch would be silly overhead IMO.

That's fine with me too. I could definitely see there being 2 or 3
headers that mid-level developers could use to identify the origin of a
patch and they could be documented.

Linus could just concern himself with atleast us subsystem-maintainers
putting the Signed-off-by on there and not worry himself about the other
headers.

Could have something like:

Spotted-by: Foo
Submitted-by: Bar
Signed-off-by: Ben Collins

And if there's a problem, Linus can come knocking on my door for fucking
up, and I'd be the bottom line responsible for the submission. Linus
need only put his confidence on a small subset of patch submitters (like
he mainly does now) doing the Signed-off-by.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

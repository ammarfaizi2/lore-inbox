Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWA0PU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWA0PU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWA0PU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:20:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22232 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751232AbWA0PU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:20:29 -0500
Date: Fri, 27 Jan 2006 15:20:28 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Message-ID: <20060127152028.GV27946@ftp.linux.org.uk>
References: <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <20060127133939.GU27946@ftp.linux.org.uk> <43DA2795.707@ti-wmc.nl> <20060127141850.GC65793@dspnet.fr.eu.org> <43DA3155.2060902@ti-wmc.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA3155.2060902@ti-wmc.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 03:42:29PM +0100, Simon Oosthoek wrote:
> hmm, so if I want to contribute to the kernel, but prefer my code to be 
> licensed under GPLv3 or higher, I would be unable to submit it to the 
> kernel unless I "lower my standards" to GPLv2 or higher?
> 
> If someone wants to use that code elsewhere, he can take it from the 
> kernel and re-use it in a GPLv2 project and further, which may violate 
> the terms of GPLv3 and would therefore conflict with my interests.
> 
> Of course, this may be purely theoretical, but it could block people 
> from submitting code to the kernel in order avoid the v2 GPL license.
> 
> From this, I think it could be concluded that it might turn out to be 
> quite harmful if code under GPLv3+ cannot be combined with the linux 
> kernel...

That's GPL working *as* *intended*.  No, you can't create a derivative
of GPLv2 program and prohibit the use of your modifications in other
GPLv2 programs.  It's not just "Linus won't accept it upstream"; it's
"you can't even distribute such fork yourself".  And it's 100% intentional -
that's what GPL is about.

As for the harm...  We somehow survived years of similar "harmful" situation.
No, you can't put proprietary code in kernel and prohibit other GPLv2
projects to reuse it.  Yes, it would theoretically turn some authors of
extremely valuable (but never materializing) code away.  And yes, there had
been very similar whining and dire warnings.  Nothing new here...

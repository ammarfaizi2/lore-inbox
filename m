Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbTFJPrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263305AbTFJPrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:47:24 -0400
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:21124 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP id S263295AbTFJPqg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:46:36 -0400
Date: Tue, 10 Jun 2003 09:00:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Kegel <dkegel@ixiacom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug 791] New: motorola sandpoint code does not compile
Message-ID: <20030610160012.GA828@ip68-0-152-218.tc.ph.cox.net>
References: <20030609152018.GE28745@ip68-0-152-218.tc.ph.cox.net> <3EE4EEA5.60106@ixiacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4EEA5.60106@ixiacom.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 01:31:33PM -0700, Dan Kegel wrote:

> Tom Rini wrote:
> >The Motorola Sandpoint code (along with many other MPC107 based
> >platforms) is out of date in 2.5.  Is there a way to close this bug and
> >have it reflect that?
> 
> Sure -- just change the name of the bug to "2.5 tree out of date
> with respect to MPC107 platforms" and add a comment saying
> where the up to date code is that needs to be merged in.
> Then leave it open to reflect the fact that the vger tree
> is out of date for these platforms.

Done.

> Isn't this an example of the eternal struggle between the vger tree and
> the trees maintained by the ppc, arm, and SH teams?  I don't

Nope.  It's a time and waiting for things to settle out in the main tree
issue.

-- 
Tom Rini
http://gate.crashing.org/~trini/

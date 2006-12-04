Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936885AbWLDU1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936885AbWLDU1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937379AbWLDU1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:27:30 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43720 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936885AbWLDU13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:27:29 -0500
Date: Mon, 4 Dec 2006 12:26:35 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-packagers@vger.kernel.org
Subject: New mailing list for Linux kernel packagers
Message-ID: <20061204202635.GA30075@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to announce a new mailing list that has been just set up.

It is oriented toward anyone who is responsible for, or involved with,
the packing up of the Linux kernel for a distro or other group of users.

The list is located at kernel-packagers@vger.kernel.org, and
instructions on how to subscribe to it can be found at
http://vger.kernel.org/ (it's the "standard" majordomo interface.)

The "charter" of the group is below.

If there are any questions about it, please let me know.

Please feel free to forward this information on to anyone that you
thinks would find it useful.

thanks,

greg k-h

---------------------------------

I'd like to propose a new mailing list for anyone involved in packaging
up the Linux kernel for a distro or for any other group of users.

In talking with a lot of different people who do this kind of thing,
I've noticed a real need for a place for everyone to come together to
try to share things that make their jobs easier.  Such topics can
include:
	- information about specific bugs that other distros might want
	  to know about
	- general discussion or coordination between distro maintainers
	  and -stable maintainers.
	- issues that are seen in packaging and other usages that might
	  not pertain to upstream due to the age of the kernel that is
	  being used.
	- discussions about how a distro can help out more with working
	  with upstream.
	- possibly discussions about unifying bugzilla issues with the
	  kernel.org bugzilla, although I think that might be better
	  served on linux-kernel still.

This will be a vendor-neutral place, hopefully hosted in a neutral
location to help foster some communication that today seems to be spread
across irc channels and private email queries.

Also, a number of vendors (non-distros) have expressed interest in such
a list, so I also think it would be acceptable to use it for:
	- a way for a single vendor to point out to all distros that
	  they might want to pick up a specific bug fix that affects
	  them.
It is only acceptable for the engineers of these vendors to use this
channel, not any marketing or product management types.  This will _not_
replace any existing procedures that the different distros have in
place for doing feature requests or bug reports to the different
distros.  It will only be a place where bugs that have already been
fixed might be gently pointed out.

If the vendors (non-distros) abuse this list, I have no qualms about
removing them from the list.  Kernel packagers' conversations take much
higher priority over individual company issues and concerns.


Note, this is NOT a place to announce security issues that should be
embargoed, or coordinated.  Or for security issues pertaining to the
upstream kernel release.  Or for patches that should be sent added to
the -stable kernel tree.  All of those things are already well covered
by existing mailing lists today (vendor-sec, security@kernel.org and
stable@kernel.org respectively.)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965468AbWJBWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965468AbWJBWCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965465AbWJBWCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 18:02:44 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:28352 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S965468AbWJBWCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 18:02:43 -0400
Date: Mon, 2 Oct 2006 14:58:12 -0700
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, "John W. Linville" <linville@tuxdriver.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002215812.GA15476@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain> <20061002212604.GA6520@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002212604.GA6520@thunk.org>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 05:26:04PM -0400, Theodore Tso wrote:
> On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> > Distributions _are_ shipping those tools already.  The problem is more
> > with older distributions where, for example, the kernel gets upgraded
> > but other stuff does not.  If a kernel upgrade happens, then the distro
> > needs to make sure userspace works with it.  That's nothing new.
> 
> Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
> thought we saw a note saying that even Debian **unstable** didn't have
> a new enough version of the wireless-tools....

	I personally never said it was shipping already in all distro.
	Debian Testing has the proper version since last May (forget
about Stable, as usual). So, Debian is in fine shape, I would say...
	Gentoo 2006.1 is obviously shipping with it.
	FC6 has it since August. It's currently in RC.
	I believe Mandriva 2007 has it, and it's also in RC. They make
it hard for non-club member to know what's happening.
	SuSE I can't figure out.
	Slackware has it in the dev version. 10.2 was one year ago, so
they are due for a new release, I guess.

	Note that both rpmseek and rpmfind are obsolete, so it's
actually a pain trying to track down all that info.

> 						- Ted

	Have fun...

	Jean

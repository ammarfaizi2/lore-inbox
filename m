Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965406AbWJBVbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965406AbWJBVbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965409AbWJBVbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:31:39 -0400
Received: from thunk.org ([69.25.196.29]:31625 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965406AbWJBVbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:31:38 -0400
Date: Mon, 2 Oct 2006 17:26:04 -0400
From: Theodore Tso <tytso@mit.edu>
To: Dan Williams <dcbw@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jt@hpl.hp.com,
       Andrew Morton <akpm@osdl.org>,
       "John W. Linville" <linville@tuxdriver.com>,
       Norbert Preining <preining@logic.at>,
       Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
       linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061002212604.GA6520@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Dan Williams <dcbw@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	jt@hpl.hp.com, Andrew Morton <akpm@osdl.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Norbert Preining <preining@logic.at>,
	Alessandro Suardi <alessandro.suardi@gmail.com>, hostap@shmoo.com,
	linux-kernel@vger.kernel.org, ipw3945-devel@lists.sourceforge.net
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <20061002111537.baa077d2.akpm@osdl.org> <20061002185550.GA14854@bougret.hpl.hp.com> <200610022147.03748.rjw@sisk.pl> <1159822831.11771.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159822831.11771.5.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 05:00:31PM -0400, Dan Williams wrote:
> Distributions _are_ shipping those tools already.  The problem is more
> with older distributions where, for example, the kernel gets upgraded
> but other stuff does not.  If a kernel upgrade happens, then the distro
> needs to make sure userspace works with it.  That's nothing new.

Um, *which* distro's are shipping it already?  RHEL4?  SLES10?  I
thought we saw a note saying that even Debian **unstable** didn't have
a new enough version of the wireless-tools....

						- Ted

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVAMVil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVAMVil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVAMVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:35:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46820 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261684AbVAMVbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:31:31 -0500
Date: Thu, 13 Jan 2005 16:30:02 -0500
From: Dave Jones <davej@redhat.com>
To: Marek Habersack <grendel@caudium.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113213002.GI3555@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marek Habersack <grendel@caudium.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
	akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112174203.GA691@logos.cnet> <1105627541.4624.24.camel@localhost.localdomain> <20050113194246.GC24970@beowulf.thanes.org> <20050113115004.Z24171@build.pdx.osdl.net> <20050113202905.GD24970@beowulf.thanes.org> <1105645267.4644.112.camel@localhost.localdomain> <20050113210229.GG24970@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113210229.GG24970@beowulf.thanes.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:02:29PM +0100, Marek Habersack wrote:
 > Theory is fine, practice is that the closed disclosure list changes matters
 > for a vaste minority of people - those who are to install the fixed kernels
 > are in perfectly the same situation they would be in if there was a fully
 > open disclosure list.

No, it's not the same. They're in a _worse_ situation if anything.
With open disclosure, the bad guys get even more lead time.

If admins don't install updates in a timely manner, there's
not a lot we can do about it.  For those that _do_ however,
we can make their lives a lot more stress free.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVAMFiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVAMFiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVAMFiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:38:20 -0500
Received: from orb.pobox.com ([207.8.226.5]:16051 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261155AbVAMFiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:38:18 -0500
Date: Wed, 12 Jan 2005 21:38:07 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Marek Habersack <grendel@caudium.net>
Cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113053807.GE4378@ip68-4-98-123.oc.oc.cox.net>
References: <20050112094807.K24171@build.pdx.osdl.net> <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050113032506.GB1212@redhat.com> <20050113035331.GC9176@beowulf.thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113035331.GC9176@beowulf.thanes.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 04:53:31AM +0100, Marek Habersack wrote:
> archived mail message or a webpage with the patch. Hoping he'll find the
> fixes in the vendor kernels, he goes to download source packages from SuSe,
> RedHat or Trustix, Debian, Ubuntu, whatever and discovers that it is as easy
> to find the patch there as it is to fish it out of the vanilla kernel patch
> for the new version. Frustrating, isn't it? Not to mention that he might

http://linux.bkbits.net is your friend.

Each patch (including security fixes) in the mainline kernels (2.4 and
2.6) appears there as an individual, clickable link with a description
(e.g. "1.1551  Paul Starzetz: sys_uselib() race vulnerability
(CAN-2004-1235)").

If other patches have gone in since then, you may have to scroll through
a (short-form) changelog. However, it's still less frustrating than the
scenario you portray.

-Barry K. Nathan <barryn@pobox.com>

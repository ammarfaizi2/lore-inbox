Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUH2Xtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUH2Xtb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 19:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268404AbUH2Xtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 19:49:31 -0400
Received: from havoc.gtf.org ([216.162.42.101]:61332 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268401AbUH2Xt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 19:49:29 -0400
Date: Sun, 29 Aug 2004 19:49:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Florian Schirmer <jolt@tuxbox.org>, pp@ee.oulu.fi,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
Message-ID: <20040829234928.GA10060@havoc.gtf.org>
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org> <41324158.4020709@pobox.com> <200408292304.25447.jolt@tuxbox.org> <20040829164528.220424e5.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829164528.220424e5.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 04:45:28PM -0700, David S. Miller wrote:
> On Sun, 29 Aug 2004 23:04:24 +0200
> Florian Schirmer <jolt@tuxbox.org> wrote:
> 
> > Sorry for that. KMail seems to mangle the message as soon as you sign
> > it. Please find the non broken versions attached to this mail.
> 
> I think Florian's changes are fine.
> 
> BTW, can someone fixup something for me?  Update MODULE_AUTHOR()
> please :-)  3/4 of this driver have been rewritten since I last
> touched it, heh.

hehe.  I'll take care of it tonight when I queue Florian's stuff
to netdev-2.6 (and thus -mm, and thus eventually mainline).

	Jeff




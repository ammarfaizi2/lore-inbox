Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWFLJ5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWFLJ5t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWFLJ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:57:49 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18821 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751410AbWFLJ5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:57:49 -0400
From: Neil Brown <neilb@suse.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Mon, 12 Jun 2006 19:57:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17549.14978.52678.562114@cse.unsw.edu.au>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
In-Reply-To: message from Russell King on Monday June 12
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	<20060611072223.GA16150@flint.arm.linux.org.uk>
	<20060612083239.GA27502@mea-ext.zmailer.org>
	<20060612084012.GA7291@flint.arm.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 12, rmk+lkml@arm.linux.org.uk wrote:
> On Mon, Jun 12, 2006 at 11:32:39AM +0300, Matti Aarnio wrote:
> > SPF is application level version of this type of source sanity
> > enforcement, and all that I intend to do is to publish that TXT
> > entry for VGER.  Analyzing SPF data in incoming SMTP reception
> > is a thing that I leave for latter phase  (how much latter,
> > I can't say yet.)
> 
> In which case I have no option but to ask - Zwane, please stop using
> my systems to forward your lkml email - Matti's proposed change will
> potentially break that setup.

Of course you do have other options.

One is to take responsibility of the mail that you forward.  I don't
necessarily mean SRS - anything that makes the mail come from a domain
which claims your server as a valid sender will do.

Another option would be to arrange with the site that you are
forwarding mail to to trust you.

Exactly what option is best for you would depend a lot on the details
of your current setup - and Zwane's.

And certainly not forwarding mail for Zwane is an option.

But there *are* multiple options.

NeilBrown

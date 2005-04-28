Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVD1VF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVD1VF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVD1VFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 17:05:54 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:32273 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262269AbVD1VFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 17:05:46 -0400
Date: Thu, 28 Apr 2005 16:26:47 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>
Subject: Re: [UML] Compile error when building with seperate source and object directories
Message-ID: <20050428202647.GA25451@ccure.user-mode-linux.org>
References: <1114570958.5983.50.camel@mythical> <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427234515.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's because that stuff is not merged yet.  Speaking of which, where does
> the current UML tree live and who should that series be Cc'ed to?

My patchset lives at http://user-mode-linux.sf.net/patches.html, and things
like this should be CC-ed to me.

> I've got a decent split-up and IMO that should be mergable.  Patches are
> on ftp.linux.org.uk/pub/people/viro/UM*; summary in the end of mail.
> That's a sanitized and split version of old UML-kbuild patch.

Thanks, merged into my tree.  It'll be visible at the above URL next time
I push the site out, and I'll merge this and a bunch of other stuff to
Linus and Andrew shortly.

				Jeff

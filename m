Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVDMM7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVDMM7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDMM7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:59:30 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:65249 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261331AbVDMM7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:59:22 -0400
Date: Wed, 13 Apr 2005 08:59:21 -0400
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
Message-ID: <20050413125921.GN17865@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425CEAC2.1050306@aitel.hist.no>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 11:47:46AM +0200, Helge Hafting wrote:
> You're not.  Complain to nvidia - using both email and snailmail.
> If everybody with such problems did that, chances are they see
> the light someday. Oh, and complain to the guy handing out
> nvidia cards like confetti, state your preference for some other
> card.  Perhaps that is easier to achieve.

What card would you recomend to people?

> Whats wrong with tainting?  It is just a message, telling you that
> the kernel is unsupported.  In this case because you're running a
> closed-source module.  The tainting message itself does not do
> anything bad.  There is a way - which is to write an open nvidia
> driver.  To do that, you'll need to get the specs out of nvidia or
> figure it out by reverse-engineering some other nvidia driver. Either
> approach is hard, so people generally find it cheaper to just buy
> a supported card.

It is becoming harder and harder to find supported cards it seems.
Finding a card with decent 2D drivers for X can still be done, but 3D is
just not really an option it seems.  Even 2D seems to be a problem on
many cards if you don't use a binary only driver.

Len Sorensen

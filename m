Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTHTMFn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbTHTMFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:05:43 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7320 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261910AbTHTMFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:05:37 -0400
Subject: Next Month/Changes to where to send stuff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061381109.32752.23.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Aug 2003 13:05:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of September I'm off back to University on a years sabbatical
from Red Hat to study for an MBA. I've made the decision that I'm
basically going to vanish for the year so I can concentrate on the
course, and on the pet side project of learning Welsh.

I've passed all my userspace projects on to other people already, and
I'll be vanishing from kernel space too (except to a few priviledged
processes ;)). Lots of people send me stuff as a gateway to getting it
into 2.4 and 2.6. Lots of people send me security related stuff.

Can you in future please send stuff to

Security: vendor-sec@lst.de
2.4: Marcelo/the list/someone he nominates to do that job
2.6: Andrew Morton or for small stuff Rusty Russell's trivial patch
manager. 

The 2.2 tree needs a new maintainer, someone who can spend their entire
life refusing patches, being ignored by the mainstream (because 2.2 is
boring) and by vendors (who don't ship 2.2 any more). 

I'm not sure what to do about the -ac patch. Most of the remaining stuff
is "pending Marcelo" for 2.4 mainstream, but not the O(1) scheduler and
some of the odder cool stuff (like the morse bits). As 2.6 becomes
relevant 2.4-ac basically becomes a fixed collection of add-ons that
aren't mainstream anyway. And of course there are other people keeping
patch sets in the same way nowdays.

A few years ago I'd have worried about doing this, the great thing is
that with the kernel community we have today I know I'm not a critical
cog in the machine. In fact I'm surrounded by people far better than I
am and we even have Andrew Morton to keep Linus in check 8)

Dal ati!

Alan


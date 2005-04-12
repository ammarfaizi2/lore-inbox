Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVDLWp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVDLWp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVDLWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:42:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:30118 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262435AbVDLWkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:40:55 -0400
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jey8bnk4lj.fsf@sykes.suse.de>
References: <1113282436.21548.42.camel@gaston>
	 <jell7nu6yk.fsf@sykes.suse.de> <1113344225.21548.108.camel@gaston>
	 <jey8bnk4lj.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 08:39:21 +1000
Message-Id: <1113345561.5387.114.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-13 at 00:33 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Yes, I noticed that too on some models, not sure what's up at this
> > point. What about the headphone jack on the front ? That one appears to
> > work.
> 
> Doesn't work either for me.  Well, I'll have keep my workaround a bit
> longer until you are ready with the rewrite.  Keep up the good work!

Doesn't work with version 2 of the patch ? neither the headphone nor the
line out jack ? hrm... does it properly detect insertion of the jack and
mute the speaker in both cases ? Can you send me a tarball of your
device-tree ?

Ben.
 


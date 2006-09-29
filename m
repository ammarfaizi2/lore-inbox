Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWI2Cpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWI2Cpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWI2Cpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:45:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:28814 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751203AbWI2Cpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:45:52 -0400
From: Neil Brown <neilb@suse.de>
To: davids@webmaster.com
Date: Fri, 29 Sep 2006 12:45:40 +1000
Message-ID: <17692.35028.84683.896718@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: GPLv3 Position Statement
In-Reply-To: message from David Schwartz on Thursday September 28
References: <20060928144028.GA21814@wohnheim.fh-wedel.de>
	<MDEHLPKNGKAHNMBLJOLKCENGOLAB.davids@webmaster.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 28, davids@webmaster.com wrote:
> 
> > In my very uninformed opinion, your problem is a very minor one.  Your
> > "v2 or later" code won't get the license v2 removed, it will become
> > dual "v2 or v3" licensed.  And assuming that v3 only adds restrictions
> > and doesn't allow the licensee any additional rights, you, as the
> > author, shouldn't have to worry much.
> >
> > The problem arises later.  As with BSD/GPL dual licensed code, where
> > anyone can take the code and relicense it as either BSD or GPL, "v2 or
> > v3" code can get relicensed as v3 only.  At this point, nothing is
> > lost, as the identical "v2 or v3" code still exists.  But with further
> > development on the "v3 only" branch, you have a fork.  And one that
> > doesn't just require technical means to get merged back, but has legal
> > restrictions.
> 
> Unless I'm missing something, you *cannot* change the license from "v2 or
> later at your option" to "v3 or later". Both GPLv2 and GPLv3 explicitly
> prohibit modifying license notices. (Did the FSF goof big time? It's not too
> late to change the draft.)

Could you point to the test in either license that prohibits modifying
license notices?
I certainly couldn't find it in section 2 of GPLv2, which seems to be
the relevant section.

Interestingly, 2.b seem to say that if I received a program under
GPLv2, and I pass it on, then I must pass it on under GPLv2-only...
So to be able to distribute something written today under GPLv3 (when
it comes into existence), you must be the original or have received it
directly from the original author....

NeilBrown

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269022AbTBWXSq>; Sun, 23 Feb 2003 18:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbTBWXSq>; Sun, 23 Feb 2003 18:18:46 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:40181 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S269022AbTBWXSp>; Sun, 23 Feb 2003 18:18:45 -0500
Date: Sun, 23 Feb 2003 18:28:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Mosberger <davidm@napali.hpl.hp.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223182856.A15376@redhat.com>
References: <E18moa2-0005cP-00@w-gerrit2> <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com> <15961.7487.465791.980935@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15961.7487.465791.980935@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Sun, Feb 23, 2003 at 11:13:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:13:03AM -0800, David Mosberger wrote:
> This simply isn't true.  Itanium and Itanium 2 have full x86 hardware
> built into the chip (for better or worse ;-).  The speed isn't as good
> as the fastest x86 chips today, but it's faster (~300MHz P6) than the

That hardly counts as reasonably performant: the slowest mainstream chips 
from Intel and AMD are clocked well over 1 GHz.  At least x86-64 will 
improve the performance of the 32 bit databases people have already 
invested large amounts of money in, and it will do so without the need 
for a massive outlay of funds for a new 64 bit license.  Why accept 
more than 10x the cost to migrate to ia64 when a new x86-64 will improve 
the speed of existing applications, and improve scalability with the 
transparent addition of a 64 bit kernel?

		-ben
-- 
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

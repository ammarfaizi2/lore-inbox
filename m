Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272859AbRIGVrC>; Fri, 7 Sep 2001 17:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272857AbRIGVqw>; Fri, 7 Sep 2001 17:46:52 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:21769 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272859AbRIGVqq>; Fri, 7 Sep 2001 17:46:46 -0400
Message-ID: <3B994057.CA799CC3@zip.com.au>
Date: Fri, 07 Sep 2001 14:47:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@ufl.edu>
CC: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.9
In-Reply-To: <3B991346.7393E7AF@zip.com.au>,
		<3B991346.7393E7AF@zip.com.au> <999897902.839.3.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> For reference, I am using 2.4.9-ac9 + ext3-0.9.9 + dir_speedup +
> kpreempt with no problem.  I have my root mounted as ext3, type ordered,
> with a local journal.
> 
> I don't have any data points on performance gains, but I would be happy
> to provide any if you specify what.  Everything feels good.

OK, thanks.

> I see no reason not to merge this into Alan's tree.  At least
> ext3-0.9.9, but the directory speedup seems reasonable enough too.

Well, it's a fairly large diff, so it's best to not force it onto
people until volunteer testers have had a week or so to try it out.

-

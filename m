Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbRHCJ6e>; Fri, 3 Aug 2001 05:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268079AbRHCJ6P>; Fri, 3 Aug 2001 05:58:15 -0400
Received: from ns.caldera.de ([212.34.180.1]:28893 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S267615AbRHCJ6D>;
	Fri, 3 Aug 2001 05:58:03 -0400
Date: Fri, 3 Aug 2001 11:57:59 +0200
Message-Id: <200108030957.f739vx322738@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Paul Jakma <paul@clubi.ie>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010803103954.A11584@emma1.emma.line.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010803103954.A11584@emma1.emma.line.org> you wrote:
> They'd just drop Linux from the list of supported OS's, Linux will
> disappoint people who trusted it, nothing is gained. Deliberate breakage
> will not happen, because it would not help anyone except people with
> twisted minds.

Who cares?  There are more than enough sane mailer around..

> NO-ONE, including you, has come up with SERIOUS objections against a
> dirsync option, except "is it really so much slower than chattr +S? show
> figures" -- ext3 is being tuned to be fast in spite of chattr +S.

Talk is cheap.  Code up a non-invasive dirsync option and submit it to
Linus.  I don't see any reason why it won't be accepted..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

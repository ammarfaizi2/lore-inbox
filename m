Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284033AbRLAJmM>; Sat, 1 Dec 2001 04:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284040AbRLAJmE>; Sat, 1 Dec 2001 04:42:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:41629 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284033AbRLAJlw>;
	Sat, 1 Dec 2001 04:41:52 -0500
Date: Sat, 1 Dec 2001 10:41:28 +0100
Message-Id: <200112010941.fB19fSb24081@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: jread@semiotek.com (Justin Wells)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Please tag tested releases of the 2.4.x kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20011130220451.9D5AD38326@fever.semiotek.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011130220451.9D5AD38326@fever.semiotek.com> you wrote:
>
> It would be great if on kernel.org there were a note indicating which 
> releases of the linux kernel had been favourably received. 
>
> If you could organize a bit you could even mark a release as "TESTED",
> or even "APPROVED". All it would mean is that after it had been out for
> a week or two nobody found any really serious problems.

Approved kernel are usually come in files ending in i386.rpm,
ia64.rpm or .deb.

Come on, no one expects stock kernel to be tested.  Distributors
on the other hand spend a lot of effort on testing their releases,
so go for a distribution kernel if you need something tested.  Really.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

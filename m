Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263174AbRFLTbJ>; Tue, 12 Jun 2001 15:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbRFLTa7>; Tue, 12 Jun 2001 15:30:59 -0400
Received: from ns.caldera.de ([212.34.180.1]:41355 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S263174AbRFLTak>;
	Tue, 12 Jun 2001 15:30:40 -0400
Date: Tue, 12 Jun 2001 21:29:50 +0200
Message-Id: <200106121929.f5CJToI08831@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kmacy@netapp.com (Kip Macy)
Cc: linux-kernel@vger.kernel.org
Subject: Re: threading question
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.10.10106121214380.20809-100000@orbit-fe.eng.netapp.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.10.10106121214380.20809-100000@orbit-fe.eng.netapp.com> you wrote:
> For heavy threading, try a user-level threads package.

Sure, userlevel threading is the best way to get SMP-scalability...

-- 
Of course it doesn't work. We've performed a software upgrade.

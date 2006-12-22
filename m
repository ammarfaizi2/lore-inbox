Return-Path: <linux-kernel-owner+w=401wt.eu-S1754817AbWLVMdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbWLVMdF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbWLVMdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:33:05 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53990 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817AbWLVMdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:33:04 -0500
Date: Fri, 22 Dec 2006 13:32:49 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Andrei Popa <andrei.popa@i-neo.ro>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222123249.GG13727@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166790275.6983.4.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrei Popa <andrei.popa@i-neo.ro> [2006-12-22 14:24]:
> With all three patches I have corruption....

I've completed one installation with Linus' patch plus the two from
Andrew successfully, but I'm currently trying again... but I really
need a better testcase since an installation takes about an hour.
Andrei, which torrent do you download as a testcase?  It would be good
if someone could suggest a torrent which is legal and not too large.
-- 
Martin Michlmayr
http://www.cyrius.com/

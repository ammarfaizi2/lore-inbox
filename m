Return-Path: <linux-kernel-owner+w=401wt.eu-S1754827AbWLVM7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbWLVM7i (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 07:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422985AbWLVM7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 07:59:38 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:54056 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbWLVM7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 07:59:38 -0500
Date: Fri, 22 Dec 2006 13:59:20 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Andrei Popa <andrei.popa@i-neo.ro>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222125920.GA16763@deprecation.cyrius.com>
References: <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com> <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost> <20061222123249.GG13727@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222123249.GG13727@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-12-22 13:32]:
> I've completed one installation with Linus' patch plus the two from
> Andrew successfully, but I'm currently trying again...

... and it failed.
-- 
Martin Michlmayr
http://www.cyrius.com/

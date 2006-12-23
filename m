Return-Path: <linux-kernel-owner+w=401wt.eu-S1752628AbWLWIQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbWLWIQJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 03:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbWLWIQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 03:16:09 -0500
Received: from [85.204.20.254] ([85.204.20.254]:37778 "EHLO megainternet.ro"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752628AbWLWIQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 03:16:08 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Andrei Popa <andrei.popa@i-neo.ro>
Reply-To: andrei.popa@i-neo.ro
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061222123249.GG13727@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
	 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org>
	 <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	 <20061221012721.68f3934b.akpm@osdl.org>
	 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	 <20061222100004.GC10273@deprecation.cyrius.com>
	 <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
	 <20061222123249.GG13727@deprecation.cyrius.com>
Content-Type: text/plain
Organization: I-NEO
Date: Sat, 23 Dec 2006 10:15:58 +0200
Message-Id: <1166861758.7411.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-22 at 13:32 +0100, Martin Michlmayr wrote:
> * Andrei Popa <andrei.popa@i-neo.ro> [2006-12-22 14:24]:
> > With all three patches I have corruption....
> 
> I've completed one installation with Linus' patch plus the two from
> Andrew successfully, but I'm currently trying again... but I really
> need a better testcase since an installation takes about an hour.
> Andrei, which torrent do you download as a testcase?  It would be good
> if someone could suggest a torrent which is legal and not too large.
It's a 1.4GB file torrent split in 84 rar files and there are many
seeders. I download with ~ 5MB/sec. The torrent is private.


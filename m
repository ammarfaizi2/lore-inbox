Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVAKVVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVAKVVT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 16:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVAKVVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 16:21:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:24206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbVAKVUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 16:20:48 -0500
Date: Tue, 11 Jan 2005 13:20:44 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Jack O'Quin" <joq@io.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111132044.M10567@build.pdx.osdl.net>
References: <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net> <20050111124707.J10567@build.pdx.osdl.net> <1105477833.4295.51.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105477833.4295.51.camel@krustophenia.net>; from rlrevell@joe-job.com on Tue, Jan 11, 2005 at 04:10:33PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Tue, 2005-01-11 at 12:47 -0800, Chris Wright wrote:
> > Guys, could we please bring this back to a useful discussion.  None of
> > you have commented on whether the rlimits for priority are useful.  As I
> > said before, I've no real problem with the module as it stands since it's
> > tiny, quite contained, and does something people need.  But I agree it'd
> > be better to find something that's workable as long term solution.
> 
> Chris, I did comment on it, see
> 1105222442.24592.126.camel@krustophenia.net from around 5:15 on
> Saturday.

Eeek, I missed/forgot (let me guess, I replied too? ;-)

Thanks Lee.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVAKUrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVAKUrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVAKUrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:47:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:4576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262156AbVAKUrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:47:08 -0500
Date: Tue, 11 Jan 2005 12:47:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matt Mackall <mpm@selenic.com>, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050111124707.J10567@build.pdx.osdl.net>
References: <20050107134941.11cecbfc.akpm@osdl.org> <20050107221059.GA17392@infradead.org> <20050107142920.K2357@build.pdx.osdl.net> <87mzvkxxck.fsf@sulphur.joq.us> <20050110212019.GG2995@waste.org> <87d5wc9gx1.fsf@sulphur.joq.us> <20050111195010.GU2940@waste.org> <871xcr3fjc.fsf@sulphur.joq.us> <20050111200549.GW2940@waste.org> <1105475349.4295.21.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1105475349.4295.21.camel@krustophenia.net>; from rlrevell@joe-job.com on Tue, Jan 11, 2005 at 03:29:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Tue, 2005-01-11 at 12:05 -0800, Matt Mackall wrote:
> > Anyway, *plonk*.
> 
> Plonk?  WTF?  Jack comes up with what many people think is a reasonable
> solution to a real problem, that affects thousands of users, and in the
> middle of what seems to me a civilized discussion, you killfile him
> because he disagrees with you?
> 
> Plonk to you too, asshole.

Guys, could we please bring this back to a useful discussion.  None of
you have commented on whether the rlimits for priority are useful.  As I
said before, I've no real problem with the module as it stands since it's
tiny, quite contained, and does something people need.  But I agree it'd
be better to find something that's workable as long term solution.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

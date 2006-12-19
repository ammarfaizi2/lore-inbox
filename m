Return-Path: <linux-kernel-owner+w=401wt.eu-S932787AbWLSK4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbWLSK4R (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbWLSK4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:56:17 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:63471 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932787AbWLSK4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:56:16 -0500
Date: Tue, 19 Dec 2006 11:56:08 +0100
From: David Weinehall <tao@acc.umu.se>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Bill Nottingham <notting@redhat.com>, Jeff Garzik <jeff@garzik.org>,
       Josh Boyer <jwboyer@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061219105608.GC19442@vasa.acc.umu.se>
Mail-Followup-To: Alan <alan@lxorguk.ukuu.org.uk>,
	Bill Nottingham <notting@redhat.com>, Jeff Garzik <jeff@garzik.org>,
	Josh Boyer <jwboyer@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
References: <457EA2FE.3050206@garzik.org> <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com> <457EA86B.5010407@garzik.org> <20061212170125.GA19592@nostromo.devel.redhat.com> <20061212172843.40edbaed@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212172843.40edbaed@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:28:43PM +0000, Alan wrote:
> On Tue, 12 Dec 2006 12:01:25 -0500
> Bill Nottingham <notting@redhat.com> wrote:
> 
> > Jeff Garzik (jeff@garzik.org) said: 
> > > It's always been the case that we remove Linux kernel code when the 
> > > number of users (and more importantly, developers) drops to near-nil.
> > 
> > So, drivers/net/3c501.c?
> 
> I think 3c501.c is a case where putting in an "If you use this email ..
> or it will go away" might be a good idea indeed.

Maybe even: "the people who are using 3c501's - please chime up and we'll
donate better cards to you."

After all, 3c501 is one of the crappier pieces of network cards,
I feel sorry for the people using them...


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/

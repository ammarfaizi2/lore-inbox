Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTIXCqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTIXCqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:46:07 -0400
Received: from [192.216.249.93] ([192.216.249.93]:14988 "EHLO tlaloc.n0ano.com")
	by vger.kernel.org with ESMTP id S261294AbTIXCqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:46:03 -0400
From: n0ano@n0ano.com
Date: Tue, 23 Sep 2003 20:40:41 -0600
To: "David S. Miller" <davem@redhat.com>
Cc: Grant Grundler <iod00d@hp.com>, bcrl@kvack.org, tony.luck@intel.com,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [OT] NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030924024040.GB2590@tlaloc.n0ano.com>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <20030923185104.GA8477@cup.hp.com> <20030923115122.41b7178f.davem@redhat.com> <20030923203819.GB8477@cup.hp.com> <20030923134529.7ea79952.davem@redhat.com> <20030923223540.GA10490@cup.hp.com> <20030923163542.55fd8ed9.davem@redhat.com> <20030924001333.GD10490@cup.hp.com> <20030923170408.0a76e68f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923170408.0a76e68f.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same way it did all exceptions, painfully slow :-)  I still think the
software exception handling on the i860 was one of it's big Achile's heels
but it got killed for other reasons before that became an issue.

On Tue, Sep 23, 2003 at 05:04:08PM -0700, David S. Miller wrote:
> On Tue, 23 Sep 2003 17:13:33 -0700
> Grant Grundler <iod00d@hp.com> wrote:
> 
> > It might. I be happy to share what I know about i860/i960 over pizza.
> > I worked on ATT SVR4 port to i860 in 1989/90 and things were quite
> > different then...
> 
> Q: How does an OS context switch work on the i860?
> A: The user sneezes and the kernel cleans up after it.
> 
> I've hung out with i860 hackers already in my past :)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@n0ano.com
Ph: 303/447-2201

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUI2RVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUI2RVj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268652AbUI2RVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:21:39 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:2820 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S268655AbUI2RV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:21:27 -0400
Date: Wed, 29 Sep 2004 12:20:58 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "Miller, Mike (OS Dev)" <mike.miller@hp.com>,
       Christoph Hellwig <hch@infradead.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
Subject: Re: patch so cciss stats are collected in /proc/stat
Message-ID: <20040929172058.GC22308@beardog.cca.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net> <1096476186.2786.45.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096476186.2786.45.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 06:43:06PM +0200, Arjan van de Ven wrote:
> On Wed, 2004-09-29 at 18:29, Miller, Mike (OS Dev) wrote:
> 
> > > This patch has been reject about half a million times, why are people
> > > submitting it again and again?
> > 
> > As I said in my mail, it's a customer driven issue. As long as customers rely on /proc/stat we'll keep trying. You can't tell a customer how he/she should be doing things on their systems.
> 
> I doubt you have many customers using 2.4.28.... I suspect that by now
> the majority of people is either using an (ancient) 2.4 vendor kernel or
> a 2.6 kernel. The very low number of reports on lkml about 2.4 seems to
> confirm that ...

Obviously no one is using 2.4.28 yet, but it's pretty hard to update the ancient kernels. I've also submitted patches to our partners to fix this in their distros.

mikem

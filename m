Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266584AbUF3IMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbUF3IMN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 04:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266583AbUF3IMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 04:12:13 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:1518 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S266584AbUF3IMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 04:12:10 -0400
To: davidm@hpl.hp.com
Cc: arjanv@redhat.com, Jeff Garzik <jgarzik@pobox.com>,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit dma allocations on 64-bit platforms
References: <20040623183535.GV827@hygelac> <40D9D7BA.7020702@pobox.com>
	<16605.1055.383447.805653@napali.hpl.hp.com>
	<1088234187.2805.3.camel@laptop.fenrus.com>
	<16609.2168.754171.270072@napali.hpl.hp.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 30 Jun 2004 04:00:00 -0400
In-Reply-To: <16609.2168.754171.270072@napali.hpl.hp.com>
Message-ID: <yq07jtp4gsf.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>> On Sat, 26 Jun 2004 09:16:27 +0200, Arjan van de Ven <arjanv@redhat.com> said:
Arjan> the real solution is an iommu of course, but the highmem
Arjan> solution has quite some merit too..... I know you disagree with
Arjan> me on that one though.

David> Yes, some merits and some faults.  The real solution is iommu
David> or 64-bit capable devices.  Interesting that graphics
David> controllers should be last to get 64-bit DMA capability,
David> considering how much more complex they are than disk
David> controllers or NICs.

You found a 64 bit capable sound card yet? ;-)

Cheers,
Jes

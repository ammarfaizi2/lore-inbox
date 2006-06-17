Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWFQAGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWFQAGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFQAGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:06:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6827 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750909AbWFQAGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:06:13 -0400
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review:
	kernel-level API support (kapi)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Stephane Eranian <eranian@hpl.hp.com>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, wcohen@redhat.com,
       perfmon@napali.hpl.hp.com
In-Reply-To: <20060616145612.GA24812@infradead.org>
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com>
	 <20060616135014.GB12657@infradead.org>
	 <20060616140234.GI10034@frankl.hpl.hp.com>
	 <20060616145612.GA24812@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 17 Jun 2006 01:15:51 +0100
Message-Id: <1150503351.8604.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-16 am 15:56 +0100, ysgrifennodd Christoph Hellwig:
> On Fri, Jun 16, 2006 at 07:02:34AM -0700, Stephane Eranian wrote:
> > Well, that's what I initially thought too but there is a need from the SystemTap
> > people and given the way they set things up, it is hard to do it from user level.
> 
> Systemtap doesn' matter.  Please don't put in useless stuff for their
> broken requirements - they're all clueless idiots.

Christoph, thank you for your detailed analytical analysis. The kernel
list would not be the same without your detailed, well explanation and
reasoned rational analyses

Alan

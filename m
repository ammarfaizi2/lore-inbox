Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFAN0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFAN0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFAN0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:26:34 -0400
Received: from main.gmane.org ([80.91.229.2]:18647 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261277AbVFAN0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:26:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: David =?utf-8?b?QmFsYcW+aWM=?= <david.balazic@hermes.si>
Subject: Re: Swap maximum size documented ?
Date: Wed, 1 Jun 2005 13:02:13 +0000 (UTC)
Message-ID: <loom.20050601T150142-941@post.gmane.org>
References: <200506011225.j51CPDV23243@lastovo.hermes.si>  <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.253.102.145 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Firefox/1.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan <at> infradead.org> writes:

> 
> 
> > > The mkwap(8) man page claims, that currently the limit is 
> > > 32 swap areas of maximum 2 gigabyte size (for x86 arch). 
> > > 
> > > Is that correct ? 
> > 
> > Not on 2.6 kernels, no.
> 
> it's not even true for 2.4 kernels btw; it was a 2.2 and before issue

OK, so can anyone tell the actual, current limits ?

Regards,
David


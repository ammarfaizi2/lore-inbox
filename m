Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUIJHQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUIJHQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 03:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUIJHPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 03:15:47 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:36997 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264726AbUIJHPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 03:15:44 -0400
Date: Fri, 10 Sep 2004 00:15:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910071530.GB4480@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <20040910064519.GA4232@taniwha.stupidest.org> <20040910065213.GA11140@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910065213.GA11140@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 08:52:13AM +0200, Arjan van de Ven wrote:

> I just did ;)

riiight

> the roadmap was
> 
> 8K stacks  ->  dual 4k/8k option -> 4k stacks

URL?


also, why 4K and not 8K or 2K?  because it's the page size?  why not
4K to then on amd64 or ppc64?

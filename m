Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUIJGqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUIJGqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUIJGpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:45:47 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:65239 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267250AbUIJGpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:45:34 -0400
Date: Thu, 9 Sep 2004 23:45:19 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040910064519.GA4232@taniwha.stupidest.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094798428.2800.3.camel@laptop.fenrus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 08:40:28AM +0200, Arjan van de Ven wrote:

> Well I always assumed the future plan was to remove 8k stacks
> entirely;

you know as well as i do that 4K stacks don't work for some people
right now and it will probably be months if not longer before this
changes

> 4k+irqstacks and 8k basically have near comparable stack space, with
> this patch you create an option that has more but that is/should be
> deprecated.

maybe, but *who* says this is depricated?



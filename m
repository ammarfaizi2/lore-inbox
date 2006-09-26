Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWIZPy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWIZPy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 11:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIZPy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 11:54:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932141AbWIZPy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 11:54:26 -0400
Date: Tue, 26 Sep 2006 16:54:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20060926155416.GB32030@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
	Chase Venters <chase.venters@clientec.com>
References: <115a6230591036@2ka.mipt.ru> <11587449471424@2ka.mipt.ru> <20060922122207.3b716028.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922122207.3b716028.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:22:07PM -0700, Andrew Morton wrote:
> On Wed, 20 Sep 2006 13:35:47 +0400
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
> > Generic event handling mechanism.
> > 
> > Consider for inclusion.
> 
> Ulrich's objections sounded substantial, and afaik remain largely
> unresolved.   How do we sort this out?

I haven't seen any of Ulrichs points (which mostly is a large subset of
my objection) beeing addressed.

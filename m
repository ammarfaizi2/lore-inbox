Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVCHKDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVCHKDJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVCHKDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:03:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44000 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261958AbVCHKCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:02:11 -0500
Date: Tue, 8 Mar 2005 05:01:57 -0500
From: Alan Cox <alan@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       alan@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luc@saillard.org, torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308100157.GC30673@devserv.devel.redhat.com>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com> <20050308053405.GA1172@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308053405.GA1172@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 05:34:06AM +0000, Christoph Hellwig wrote:
> Agree with greg on all these bits, and similar (although not as bad) for
> the other bits Alan sent.  Alan, could you please go through the subsystem
> maintainer & -mm process like everyone else?  A little public review
> can't hurt your patches either.

I sent it to Andrew the day Linus removed it, nothing happened. I got fed up
of people asking why the most used webcam driver is -ac only.


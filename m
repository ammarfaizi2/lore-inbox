Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVCHFhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVCHFhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCHFhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:37:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58564 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261436AbVCHFeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:34:10 -0500
Date: Tue, 8 Mar 2005 05:34:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: alan@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luc@saillard.org, torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308053405.GA1172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, alan@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	luc@saillard.org, torvalds@osdl.org
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308052643.GA16222@kroah.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:26:43PM -0800, Greg KH wrote:
> Ick, Alan, couldn't you have had the decency to run this through the USB
> developers, and at least pinged me on it?  Especially due to all of the
> hate-email I have gotten over this driver in the past.
> 
> As it is, the coding style sucks in places, and you didn't really need
> to make it a new subdirectory (although due to the increased size of the
> driver, it's probably better now...)
> 
> And, there's no MAINTAINERS entry for who I need to bug about this
> thing.

Agree with greg on all these bits, and similar (although not as bad) for
the other bits Alan sent.  Alan, could you please go through the subsystem
maintainer & -mm process like everyone else?  A little public review
can't hurt your patches either.

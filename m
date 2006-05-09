Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWEIPWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWEIPWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWEIPWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:22:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53164 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932521AbWEIPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:22:42 -0400
Date: Tue, 9 May 2006 16:22:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com
Subject: Re: [RFC PATCH 00/35] Xen i386 paravirtualization support
Message-ID: <20060509152240.GA17837@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>,
	linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
	xen-devel@lists.xensource.com
References: <20060509084945.373541000@sous-sol.org> <4460AC01.5020503@mbligh.org> <20060509150701.GA14050@infradead.org> <p73k68v4444.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73k68v4444.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 05:20:11PM +0200, Andi Kleen wrote:
> > It's also wrong.  There's more than one hypervisor and Xen shouldn't just
> > grab this namespace.  make it xen_ or xenhv_.
> 
> You should reject the recent "hypervisor file system" with the same
> argument then.

I prefer it would become lparfs or something like that indeed.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWD0VAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWD0VAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWD0VAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:00:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751662AbWD0VAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:00:53 -0400
Date: Thu, 27 Apr 2006 22:00:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Martin Bligh <mbligh@google.com>, Andrew Morton <akpm@osdl.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
Message-ID: <20060427210040.GA18873@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Martin Bligh <mbligh@google.com>,
	Andrew Morton <akpm@osdl.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org> <20060427131100.05970d65.akpm@osdl.org> <44512B61.4040000@google.com> <200604272156.11606.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604272156.11606.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 09:56:11PM +0200, Andi Kleen wrote:
> On Thursday 27 April 2006 22:36, Martin Bligh wrote:
> 
> 
> >
> > > - Matches kernel coding style(!)
> >
> > E_NEEDS_AUTOMATED_FILTER / lint of some form.
> 
> Some Unixes have a cstyle(1). Maybe there is a free variant of it somewhere.
> But such a tool might put a lot of people on l-k out of job @)

apparently the solaris one is released now as free software.  haven't
actually looked at it yet, and it'd surely need various changes to
enforce the linux rules.


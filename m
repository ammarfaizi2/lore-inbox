Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWFPO4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWFPO4P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 10:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWFPO4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 10:56:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61917 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751430AbWFPO4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 10:56:15 -0400
Date: Fri, 16 Jun 2006 15:56:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com, wcohen@redhat.com,
       perfmon@napali.hpl.hp.com
Subject: Re: [PATCH 9/16] 2.6.17-rc6 perfmon2 patch for review: kernel-level API support (kapi)
Message-ID: <20060616145612.GA24812@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@hpl.hp.com>, linux-kernel@vger.kernel.org,
	systemtap@sources.redhat.com, wcohen@redhat.com,
	perfmon@napali.hpl.hp.com
References: <200606150907.k5F97coF008178@frankl.hpl.hp.com> <20060616135014.GB12657@infradead.org> <20060616140234.GI10034@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616140234.GI10034@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 07:02:34AM -0700, Stephane Eranian wrote:
> Well, that's what I initially thought too but there is a need from the SystemTap
> people and given the way they set things up, it is hard to do it from user level.

Systemtap doesn' matter.  Please don't put in useless stuff for their
broken requirements - they're all clueless idiots.


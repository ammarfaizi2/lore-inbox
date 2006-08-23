Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWHWP1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWHWP1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHWP1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:27:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:743 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964981AbWHWP1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:27:16 -0400
Date: Wed, 23 Aug 2006 16:27:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823152714.GB32725@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephane Eranian <eranian@frankl.hpl.hp.com>,
	linux-kernel@vger.kernel.org, eranian@hpl.hp.com
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608230805.k7N85qo2000348@frankl.hpl.hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 01:05:52AM -0700, Stephane Eranian wrote:
> Hello,
> 
> The following series of patches includes the generic perfmon2
> subsystem and the support for i386, x86_64, and powerpc. The perfmon2
> subsystem also works on MIPS and all Itanium processors. The Itanium support
> is not posted because it does not easily accomodate the 100k message
> limit of lkml. The powerpc support is still very preliminary.
> 
> The patches are relative to 2.6.17.9

pleas submit patches always against latest Linus' tree or -mm.  2.6.17.9
is already megabytes of diffs away from mainline.


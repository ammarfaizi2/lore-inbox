Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVF2HV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVF2HV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVF2HV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:21:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38351 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262458AbVF2HVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:21:21 -0400
Date: Wed, 29 Jun 2005 08:21:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
Message-ID: <20050629072115.GA17261@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi,
	linux-kernel@vger.kernel.org
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi> <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <20050628163114.6594e1e1.akpm@osdl.org> <20050629070729.GB16850@infradead.org> <20050629001717.65fb272c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629001717.65fb272c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:17:17AM -0700, Andrew Morton wrote:
> Come to think of it, it could be a problem if the comnpiler was silly and
> built an entire temporary on the stack and the copied it over.  Hopefull it
> won't do that.

that patch is fine except for the second to last patch which should be
droped.

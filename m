Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVF2HHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVF2HHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 03:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVF2HHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 03:07:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19919 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262454AbVF2HHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 03:07:02 -0400
Date: Wed, 29 Jun 2005 08:07:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] freevxfs: remove 2.4 compatability
Message-ID: <20050629070701.GA16850@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi> <iit0hc.owmgrf.a8mlfisjmja2ab31fpl1ysmkp.refire@cs.helsinki.fi> <20050628163338.321e3216.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628163338.321e3216.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 04:33:38PM -0700, Andrew Morton wrote:
> Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> >
> > This patch removes 2.4 compatability header from freevxfs.
> 
> Maybe.  That's a bit of a pain if someone is actually maintaining this one
> codebase under both kernels though...

the header can go, these days there's too much difference for it to make
any sense.

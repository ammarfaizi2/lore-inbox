Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVB1VfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVB1VfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVB1VfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 16:35:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261749AbVB1VfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 16:35:13 -0500
Date: Mon, 28 Feb 2005 21:35:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perthread_pages_alloc cleanup
Message-ID: <20050228213509.GB18162@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Hicks <mort@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050228155248.GR26705@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228155248.GR26705@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 10:52:48AM -0500, Martin Hicks wrote:
> 
> Hi Andrew,
> 
> This is just a cleanup - no functional changes.  Gets a bunch of code
> outside an if by returning NULL earlier.

the last discussion of that code had the outcome we should just drop
it, probably not worth wasting any time on it.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVDYOcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVDYOcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVDYOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:32:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11676 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262617AbVDYOcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:32:15 -0400
Date: Mon, 25 Apr 2005 15:32:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] mspec driver for 2.6.12-rc2-mm3
Message-ID: <20050425143211.GA9902@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16987.39773.267117.925489@jaguar.mkp.net> <20050412032747.51c0c514.akpm@osdl.org> <yq07jj8123j.fsf@jaguar.mkp.net> <20050413204335.GA17012@infradead.org> <yq08y3bys4e.fsf@jaguar.mkp.net> <20050424101615.GA22393@infradead.org> <yq03btftb9u.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq03btftb9u.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 06:13:01AM -0400, Jes Sorensen wrote:
> >>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
> 
> >>  The code use the size to calculate, it could be changed either
> >> way, don't think it's worth making the change.
> 
> Christoph> The current code is obsufcated, see the pages-1 stuff and
> Christoph> co.  Please change it.
> 
> Both ways work, this is down to nitpicking for the sake of
> nitpicking. Whatever, I'll change it.

It's nitpicking to keep the code readable.  Same thing as always using
named initializers for method vectors or similar things.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVAGLPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVAGLPN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVAGLPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:15:13 -0500
Received: from [213.146.154.40] ([213.146.154.40]:2747 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261258AbVAGLPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:15:09 -0500
Date: Fri, 7 Jan 2005 11:15:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Cc: linux-kernel@vger.kernel.org, debian-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050107111508.GA6667@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>,
	linux-kernel@vger.kernel.org, debian-kernel@vger.kernel.org
References: <1105096053.5444.11.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105096053.5444.11.camel@ulysse.olympe.o2t>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 12:07:33PM +0100, Nicolas Mailhot wrote:
> Hi all, 
> 
> Since 2.6 is turning into a continuous release, how about just taking
> the last 2.6 release every six months and backport security fixes to it
> for the next half year ?

Half a year is far too long because hardware is changing to fast for that.
Three month sounds like a much better idea.

The real problem is that this is a really time-consuming issue, so
there need to be people actually commited to doing this kind of thing.

Andres Salomon from the Debian Kernel maintaince team has been thinking
about such a bugfix tree, but he's worried about having the time to
actually get the work done - and we know what we're talking about as
we're trying to keep a properly fixed 2.6.8 tree for Debian sarge.


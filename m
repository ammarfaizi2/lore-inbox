Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUJRUyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUJRUyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUJRUxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:53:55 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:61191 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267377AbUJRUw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:52:56 -0400
Date: Mon, 18 Oct 2004 21:52:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Enough with the ad-hoc naming schemes, please
Message-ID: <20041018205239.GA2282@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20041018180851.GA28904@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041018180851.GA28904@waste.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2004 at 01:08:51PM -0500, Matt Mackall wrote:
> Dear Linus,
> 
> I can't help but notice you've broken all the tools that rely on a
> stable naming scheme TWICE in the span of LESS THAN ONE POINT RELEASE.
> 
> In both cases, this could have been avoided by using Marcello's 2.4
> naming scheme. It's very simple: when you think something is "final",
> you call it a "release candidate" and tag it "-rcX". If it works out,
> you rename it _unmodified_ and everyone can trust that it hasn't
> broken again in the interval. If it's not "final" and you're accepting
> more than bugfixes, you call it a "pre-release" and tag it "-pre".
> Then developers and testers and automated tools all know what to
> expect.

indeed, the current -rc are really the good old -pre, and -final ir just
a completely stupid name for -rc.  Please try to get some sanity back into
the release naming.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265215AbUF1VT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUF1VT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUF1VT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:19:26 -0400
Received: from havoc.gtf.org ([216.162.42.101]:43168 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265215AbUF1VSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:18:07 -0400
Date: Mon, 28 Jun 2004 17:18:01 -0400
From: David Eger <eger@havoc.gtf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, jdike@addtoit.com, blaisorblade_spam@yahoo.it,
       linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-ID: <20040628211801.GA7824@havoc.gtf.org>
References: <200406261905.22710.blaisorblade_spam@yahoo.it> <20040626130945.190fb199.akpm@osdl.org> <20040627035923.GB8842@ccure.user-mode-linux.org> <20040626233253.06ed314e.pj@sgi.com> <20040626234025.7d69937c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626234025.7d69937c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 26, 2004 at 11:40:25PM -0700, Andrew Morton wrote:
>
> > But work in progress, for which oneself is still the primary source, is
> > fluid.  You can slice and dice and redo it, and indeed you want to, to
> > get the best patch set.  Quilt and friends rule for this stuff.
> 
> Good description, that.  quilt is a grown-up version of patch-scripts, and
> is tailored to what I do, and to what distributors do: maintain a series of
> diffs against a monolithic tree which someone else maintains.
> 
> > Conclusion - use Quilt (with your favorite personal version control) on
> > top of Bitkeeper.
> 
> yup.  I use patch-scripts+CVS in the way which you describe.

I had been wondering how you deal with so many patches...
So do people actually use bitKeeper for more than the following:

(1) glorified 'cp -r'
(2) memory of the history of the tree from which we did a 'cp -r'

-dte

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVFFIUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVFFIUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVFFIUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:20:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1548 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261225AbVFFITl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:19:41 -0400
Date: Mon, 6 Jun 2005 10:19:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: joern@wohnheim.fh-wedel.de
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606081928.GA15312@alpha.home.local>
References: <20050605223528.GA13726@alpha.home.local> <20050606074745.GC24826@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606074745.GC24826@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 09:47:45AM +0200, J?rn Engel wrote:
> On Mon, 6 June 2005 00:35:28 +0200, Willy Tarreau wrote:
> > 
> > I recently discovered p7zip which comes with the LZMA compression algorithm,
> > which is somewhat better than gzip and bzip2 on most datasets, [...]
> 
> Hmmm.
> 
> Citeseer has never heard of that algorithm, top 10 google hits for
> "LZMA compression algorithm" are completely uninformative.  Does
> anyone actually know, what this algorithm is doing?

It's described here :
   http://en.wikipedia.org/wiki/LZMA

implemented here :
   http://martinus.geekisp.com/rublog.cgi/Projects/LZMA

and here :
   http://www.7-zip.org/sdk.html

Willy


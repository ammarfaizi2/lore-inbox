Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFFJr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFFJr0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFFJr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:47:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:62098 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261266AbVFFJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:47:22 -0400
Date: Mon, 6 Jun 2005 11:46:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606094656.GA31739@wohnheim.fh-wedel.de>
References: <20050605223528.GA13726@alpha.home.local> <20050606074745.GC24826@wohnheim.fh-wedel.de> <20050606081928.GA15312@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050606081928.GA15312@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 June 2005 10:19:28 +0200, Willy Tarreau wrote:
> On Mon, Jun 06, 2005 at 09:47:45AM +0200, J?rn Engel wrote:
> > 
> > Citeseer has never heard of that algorithm, top 10 google hits for
> > "LZMA compression algorithm" are completely uninformative.  Does
> > anyone actually know, what this algorithm is doing?
> 
> It's described here :
>    http://en.wikipedia.org/wiki/LZMA
> 
> implemented here :
>    http://martinus.geekisp.com/rublog.cgi/Projects/LZMA
> 
> and here :
>    http://www.7-zip.org/sdk.html

Thanks, but I already saw all three of those before I posted my reply.
Guess the only way to tell is by reading the source...

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.

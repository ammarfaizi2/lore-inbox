Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVGDJVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGDJVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 05:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVGDJVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 05:21:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54491 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261591AbVGDJRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 05:17:53 -0400
Date: Mon, 4 Jul 2005 10:16:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, David Weinehall <tao@acc.umu.se>,
       Markus T?rnqvist <mjt@nysv.org>, Douglas McNaught <doug@mcnaught.org>,
       Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050704091622.GA29230@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	David Masover <ninja@slaphack.com>,
	David Weinehall <tao@acc.umu.se>, Markus T?rnqvist <mjt@nysv.org>,
	Douglas McNaught <doug@mcnaught.org>,
	Hubert Chan <hubert@uhoreg.ca>, Kyle Moffett <mrmacman_g4@mac.com>,
	Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
	Gregory Maxwell <gmaxwell@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200507020148.j621m9m0006559@laptop11.inf.utfsm.cl> <42C8B020.7040506@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C8B020.7040506@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 08:42:24PM -0700, Hans Reiser wrote:
> >>Right.  But, /proc started somewhere, didn't it?
> >>    
> >>
> >
> >Sun.
> >  
> >
> No, plan 9.

Almost on the right track, it was v8, two steps before plan9.  But that's
just the process-part of procfs, not the big mess we have now - that part
is pretty much linux-only.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWDCPpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWDCPpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWDCPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:45:20 -0400
Received: from unthought.net ([212.97.129.88]:8202 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751738AbWDCPpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:45:20 -0400
Date: Mon, 3 Apr 2006 17:45:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060403154519.GB14981@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <1143820520.8096.24.camel@lade.trondhjem.org> <20060331160426.GN9811@unthought.net> <20060403152628.GA14981@unthought.net> <1144078900.9111.41.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144078900.9111.41.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 11:41:40AM -0400, Trond Myklebust wrote:
..
> > Could I ask you to try: 
> >  for i in `seq 1 100`; do time ./nfsbench; done
> > or something like that?
> 
> OK. Thanks for helping narrow this down! I'm travelling right now, so I
> can't promise that I'll be able to run any tests until tomorrow. I'll
> have a look, though.

Thanks a lot, and no problem :)

-- 

 / jakob


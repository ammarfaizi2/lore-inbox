Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTIYR6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTIYR6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:58:06 -0400
Received: from havoc.gtf.org ([63.247.75.124]:56290 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261396AbTIYR5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:57:37 -0400
Date: Thu, 25 Sep 2003 13:57:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, andrea@kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: log-buf-len dynamic
Message-ID: <20030925175735.GB21341@gtf.org>
References: <m1n0csiybu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309251026550.29320-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 10:30:58AM -0700, Linus Torvalds wrote:
> I don't know what the solution to it might be - but I don't think the 
> reason they are using BK is that they are trying to emulate "the great 
> kernel project". I know it wasn't for me - it's just that once you get 
> used to BK, there's no way you'll ever go back to CVS willingly. 

Nod.  All my new projects start out in BitKeeper these days, because
it's so much better than cvs.

	Jeff




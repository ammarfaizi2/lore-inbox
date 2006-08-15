Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbWHOTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbWHOTcj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWHOTcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:32:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41390 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030482AbWHOTci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:32:38 -0400
Date: Tue, 15 Aug 2006 12:32:01 -0700
From: Greg KH <gregkh@suse.de>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [git patches] ocfs2 updates
Message-ID: <20060815193201.GA14785@suse.de>
References: <20060815192006.GJ10876@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815192006.GJ10876@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 12:20:06PM -0700, Mark Fasheh wrote:
> This set of patches includes a few dlm related fixes from Kurt, and a small,
> trivial cleanup by Adrian.
> 
> Also included are three disk allocation patches by me - two fixes and one
> incremental improvement in our allocation strategy. These have been around
> since early June, so I think they've had enough testing that they can go
> upstream.
> 
> Please pull from 'upstream-linus' branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

Pulled from, and pushed back out, thanks.

greg k-h

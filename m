Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbVJXCDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVJXCDb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 22:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVJXCDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 22:03:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36286 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750918AbVJXCDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 22:03:30 -0400
Date: Mon, 24 Oct 2005 03:03:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus <torvalds@osdl.org>
Subject: Re: [PATCH] propogate gfp_t changes further
Message-ID: <20051024020325.GI7992@ftp.linux.org.uk>
References: <20051024110736.7bbe004e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024110736.7bbe004e.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 11:07:36AM +1000, Stephen Rothwell wrote:
> 
> This small patch gits rid of a couple of compile warnings.

... #4, by now.

Linus, maybe I should just send the entire series your way?  Unless you
are planning to push 2.6.14 Real Soon Now(tm), it would make sense...

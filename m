Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTK2RCi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263821AbTK2RCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:02:37 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:43178 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263805AbTK2RBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:01:09 -0500
Date: Sat, 29 Nov 2003 09:01:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tim Cambrant <tim@cambrant.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Too soon for stable release?
Message-ID: <20031129170104.GA15333@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tim Cambrant <tim@cambrant.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20031129174916.GA4592@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129174916.GA4592@cambrant.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 06:49:16PM +0100, Tim Cambrant wrote:
> I am sorry if this offends someone or if I'm totally on the wrong track
> here, but it seems odd to actually call the Beaver On Detox "stable",
> considering the amount of misc. problems people have been having the
> last week with -test11. 

The "stable" series of the kernel is never really stable for a while. 
A better way to think of it is as "that place where things become stable
by refusing to take any new changes except bug fixes".  

The news media hasn't picked up on this yet, they seem to think that
2.6.0 is something that will be useful.  It won't be, there will be a
period of months during which things stablize and then you'll see the
distros pick up the release.  I don't remember where it was exactly
(2.4.18?) but Red Hat waited quite a while before switching to 2.4
from 2.2.  This is normal and it works out quite well in practice.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

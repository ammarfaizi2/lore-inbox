Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUFDXrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUFDXrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUFDXrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:47:42 -0400
Received: from palrel13.hp.com ([156.153.255.238]:17837 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264452AbUFDXrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:47:32 -0400
Date: Fri, 4 Jun 2004 16:43:01 -0700
From: Grant Grundler <iod00d@hp.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       davidm@hpl.hp.com, akpm@osdl.org, willy@debian.org
Subject: Re: [PATCH] ia64 MAINTAINERS update
Message-ID: <20040604234301.GN11111@cup.hp.com>
References: <200406041551.25405.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406041551.25405.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 03:51:25PM -0700, Jesse Barnes wrote:
> Dave Hansen pointed out that linux-ia64@linuxia64.org is broken.  Since the 
> list has moved and the domain is gone, update the list address and kill the 
> URL.  I think willy has a new domain for ia64 Linux, but it was down for me, 
> so I'll let him update the file later with the new URL if he wants to.

The correct URL still is:
	http://www.ia64-linux.org/

Please update the URL.

grundler <512>host www.ia64-linux.org
www.ia64-linux.org has address 192.25.206.7

192.25.206.7 also hosted parisc-linux.org.
But recently all the parisc-linux services migrated to another box.
I'm not sure when/why the "old" box was disconnected or
if it just crashed.

In any case, despite being at gcc-summit conf, willy did find time to
migrate ia64-linux.org to the same host as parisc-linux.org.
IIRC, that was yesterday. The DNS just hasn't propagated yet
but ISTR willy said it would today at some point.

The entire ia64-linux web site is available via anon CVS.
See cvs.parisc-linux.org but use "ia64-web" instead as
the repository.

I've checked out a snapshot anyone can access for now on
	http://iou.parisc-linux.org/ia64-web/

hth,
grant

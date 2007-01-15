Return-Path: <linux-kernel-owner+w=401wt.eu-S932489AbXAQPg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbXAQPg4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 10:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbXAQPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 10:36:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1923 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932489AbXAQPgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 10:36:55 -0500
Date: Mon, 15 Jan 2007 13:05:56 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 17/20] XEN-paravirt: Add Xen grant table support
Message-ID: <20070115130556.GB4272@ucw.cz>
References: <20070113014539.408244126@goop.org> <20070113014648.925356430@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070113014648.925356430@goop.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  drivers/xen/core/Makefile |    2
>  drivers/xen/core/gnttab.c |  422 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/xen/gnttab.h      |  105 +++++++++++
>  3 files changed, 528 insertions(+), 1 deletion(-)
...
> ===================================================================
> --- /dev/null
> +++ b/drivers/xen/core/grant_table.c

What is going on? Diffstat does not seem to match the diff.


						Pavel
-- 
Thanks for all the (sleeping) penguins.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVFTHv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVFTHv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 03:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVFTHv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 03:51:27 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:52626 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261483AbVFTHtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 03:49:05 -0400
Subject: Re: [patch 2/2] stats for orphaned pages (-mm only)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, andrea@suse.de, mason@suse.de
In-Reply-To: <20050620003647.283ba186.akpm@osdl.org>
References: <1118978590.5261.4.camel@npiggin-nld.site>
	 <1119252194.6240.22.camel@npiggin-nld.site>
	 <1119252269.6240.25.camel@npiggin-nld.site>
	 <20050620003647.283ba186.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 17:49:01 +1000
Message-Id: <1119253741.6240.35.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 00:36 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > And this.
> > 
> > ...
> > 
> > [vm-orphaned-debug.patch  text/x-patch (3472 bytes)]
> 
> yup.  Observing the chnages in these numbers across various workloads would
> go a long way toward validating the need for some patch and toward
> validating a particular patch's effectiveness too.

I'll try getting some numbers shortly.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 

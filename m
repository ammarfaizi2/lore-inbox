Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUK3CqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUK3CqM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUK3Cpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:45:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:57047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261965AbUK3Cnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:43:40 -0500
Date: Mon, 29 Nov 2004 18:43:21 -0800
From: Greg KH <greg@kroah.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 0/10 Class Based Kernel Resource Management
Message-ID: <20041130024321.GA6317@kroah.com>
References: <E1CYqW1-00056B-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqW1-00056B-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 10:44:49AM -0800, Gerrit Huizenga wrote:
> 09-diff_rbce
> 	A very basic rules based classification engine for automatically
> 	adding tasks to classes.  Also includes an enhanced rules based
> 	classification engine with better per-process delay data and
> 	ability to better monitor class related activities.

This one didn't look like it made it to lkml.

Oh, and I stopped reviewing the other patches in the series, as the same
comments pretty much applied to them :(

thanks,

greg k-h

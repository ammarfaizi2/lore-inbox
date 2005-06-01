Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVFAUq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVFAUq1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFAUpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:45:53 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:48275 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261219AbVFAUnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:43:51 -0400
Date: Wed, 1 Jun 2005 16:43:50 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Swap maximum size documented ?
Message-ID: <20050601204350.GM23621@csclub.uwaterloo.ca>
References: <200506011225.j51CPDV23243@lastovo.hermes.si> <20050601124025.GZ422@unthought.net> <1117630718.6271.31.camel@laptopd505.fenrus.org> <loom.20050601T150142-941@post.gmane.org> <20050601134022.GM20782@holomorphy.com> <429E0843.5060505@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429E0843.5060505@tmr.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 03:10:59PM -0400, Bill Davidsen wrote:
> Does this apply to mmap as well? I have an application which currently 
> uses 9TB of data, and one thought to boost performance was to mmap the 
> data. Unfortunately, I know 16TB isn't going to be enough for more than 
> a few more years :-(

Just buy an Opteron/Athlon64 system and you should be able to mmap it
just fine.  At least if you run an x86_64/amd64 kernel.

Len Sorensen

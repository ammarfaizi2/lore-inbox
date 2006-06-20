Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWFTKpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWFTKpG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWFTKpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:45:05 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9088 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S932564AbWFTKpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:45:04 -0400
Date: Tue, 20 Jun 2006 03:44:16 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Chris Wright <chrisw@sous-sol.org>, stable@kernel.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17.1
Message-ID: <20060620104416.GG23467@sequoia.sous-sol.org>
References: <20060620101350.GE23467@sequoia.sous-sol.org> <200606201235.19811.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606201235.19811.mb@bu3sch.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch (mb@bu3sch.de) wrote:
> On Tuesday 20 June 2006 12:13, Chris Wright wrote:
> > We (the -stable team) are announcing the release of the 2.6.17.1 kernel.
> 
> Please consider inclusion of the following patch into 2.6.17.2:
> 
> It fixes a possible crash. Might be triggerable in networks with
> heavy traffic. I only saw it once so far, though.

I didn't notice that it made it to Linus' tree yet.  Can you make sure
to push it up, and I'll queue it for -stable.

thanks,
-chris

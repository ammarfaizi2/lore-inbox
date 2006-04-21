Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWDUUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWDUUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWDUUY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 16:24:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50563 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750745AbWDUUY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 16:24:27 -0400
Date: Fri, 21 Apr 2006 13:22:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: chrisw@sous-sol.org, gregkh@suse.de, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the Root Plug Support sample module
Message-ID: <20060421202203.GK3061@sorel.sous-sol.org>
References: <20060421201943.GJ19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421201943.GJ19754@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> No matter whether LSM will stay or not, there's no reason to include a 
> sample module in the build (e.g. Debian kernels are currently shipping 
> this module).

I've no issue with this.  Greg, unless you object, I'll pick this one up.

thanks,
-chris

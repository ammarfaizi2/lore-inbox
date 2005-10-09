Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVJIIJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJIIJu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVJIIJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:09:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932239AbVJIIJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:09:50 -0400
Date: Sun, 9 Oct 2005 01:09:37 -0700
From: Chris Wright <chrisw@osdl.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: webmaster@kernel.org, security@kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Security] "stable" vs "security stable"
Message-ID: <20051009080937.GS5856@shell0.pdx.osdl.net>
References: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Coywolf Qi Hunt (coywolf@gmail.com) wrote:
> I find the kernel.org first page inconvenient for some people somehow
> since the security stable came.

It's stable, not security stable.  It does contain security fixes
sometimes, but it is generally about patches that improve kernel
stability.

> Now on the kernel.org page, we have 2.6.13.3 and 2.6.14-rc3. If one
> wants to get 2.6.14-rc3, he shouldn't get 2.6.14-rc3 Full, but
> 2.6.14-rc3 Patch and 2.6.13 Full, which isn't there unfortunately. I
> suggest we name 2.6.13.3 "security stable", and 2.6.13 "stable".

Perhaps a column B for base.  Or just link to ketchup and be done with it.

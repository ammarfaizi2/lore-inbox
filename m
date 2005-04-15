Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVDOSNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVDOSNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVDOSNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:13:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:6866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261893AbVDOSMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:12:06 -0400
Date: Fri, 15 Apr 2005 11:12:01 -0700
From: Chris Wright <chrisw@osdl.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
Message-ID: <20050415181201.GD23013@shell0.pdx.osdl.net>
References: <6533c1c905041511041b846967@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6533c1c905041511041b846967@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Igor Shmukler (igor.shmukler@gmail.com) wrote:
> We are working on a LKM for the 2.6 kernel.
> We HAVE to intercept system calls. I understand this could be
> something developers are no encouraged to do these days, but we need
> this.

I don't think you'll find much empathy or support here.  This is seriously
discouraged.  It's usually the beginning of many ugly and suspect things
being done in a module.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

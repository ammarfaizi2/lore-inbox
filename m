Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbUKKXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUKKXbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKKXbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:31:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:20654 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262464AbUKKXbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:31:34 -0500
Date: Thu, 11 Nov 2004 15:31:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ed Schouten <ed@il.fontys.nl>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: a.out issue
Message-ID: <20041111153129.B2357@build.pdx.osdl.net>
References: <20041111220906.GA1670@dereference.de> <20041111143258.Q14339@build.pdx.osdl.net> <20041111230509.GA9494@il.fontys.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041111230509.GA9494@il.fontys.nl>; from ed@il.fontys.nl on Fri, Nov 12, 2004 at 12:05:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ed Schouten (ed@il.fontys.nl) wrote:
> Have you set:
> 
> sysctl -w vm.overcommit_memory=1

I actually set it to 2, now with 1 it's Oopsing.  Thanks.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

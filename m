Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVG1SZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVG1SZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVG1SX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 14:23:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261674AbVG1SWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 14:22:12 -0400
Date: Thu, 28 Jul 2005 11:22:04 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Fw: [PATCH] bio_clone fix
Message-ID: <20050728182204.GB19052@shell0.pdx.osdl.net>
References: <20050728110226.4fa98645.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728110226.4fa98645.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> 
> This is an important fix affecting both 2.6.11 and 2.6.12.  Anyone who is
> experiencing data loss issues on MD or DM setups with those kernels should
> apply.

Thanks, queued to -stable.
-chris

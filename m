Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVAWXAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVAWXAT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 18:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVAWXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 18:00:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:29122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261373AbVAWW7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:59:24 -0500
Date: Sun, 23 Jan 2005 14:59:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, "Michael A. Halcrow" <mike@halcrow.us>,
       Serge Hallyn <hallyn@cs.wm.edu>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] security/seclvl.c: make some code static
Message-ID: <20050123145923.U469@build.pdx.osdl.net>
References: <20050123101640.GG3212@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050123101640.GG3212@stusta.de>; from bunk@stusta.de on Sun, Jan 23, 2005 at 11:16:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk (bunk@stusta.de) wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

ACK, I'll push this up if Andrew doesn't grab it.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

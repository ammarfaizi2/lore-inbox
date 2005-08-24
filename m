Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVHXSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVHXSNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVHXSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:13:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49313 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751342AbVHXSNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:13:11 -0400
Date: Wed, 24 Aug 2005 11:13:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kgdbwait in 2.6.13-rc4-mm1?
Message-ID: <20050824181309.GA15735@smtp.west.cox.net>
References: <194B303F2F7B534594F2AB2D87269D9F06DE070A@orsmsx408>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194B303F2F7B534594F2AB2D87269D9F06DE070A@orsmsx408>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:22:06AM -0700, Wilkerson, Bryan P wrote:

> Is there an equivalent kernel boot option for kgdbwait in
> 2.6.13-rc4-mm1?  I grep'd the kernel source but didn't find kgdbwait.

It's 'kgdb' or 'gdb', I forget which.

-- 
Tom Rini
http://gate.crashing.org/~trini/

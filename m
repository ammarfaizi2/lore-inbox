Return-Path: <linux-kernel-owner+w=401wt.eu-S1750866AbXAAUIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbXAAUIW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbXAAUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:08:22 -0500
Received: from [198.99.130.12] ([198.99.130.12]:52783 "EHLO
	saraswathi.solana.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1750866AbXAAUIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:08:22 -0500
Date: Mon, 1 Jan 2007 15:03:01 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/6] UML - Console locking fixes
Message-ID: <20070101200301.GD20792@ccure.user-mode-linux.org>
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org> <20061229154802.b0768d6e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229154802.b0768d6e.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 03:48:02PM -0800, Randy Dunlap wrote:
> /*
>  * Normally, ...

> 	if (
> 	(several of these)

Yeah, I'm working off the most blatant style violations at the moment.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

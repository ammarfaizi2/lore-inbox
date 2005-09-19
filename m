Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVISTCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVISTCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 15:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVISTCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 15:02:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932584AbVISTCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 15:02:10 -0400
Date: Mon, 19 Sep 2005 12:01:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 1/1] uml - Fix x86_64 page leak
Message-ID: <20050919190146.GW7762@shell0.pdx.osdl.net>
References: <20050919180231.358170000@zion.home.lan> <20050919180321.615510000@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050919180321.615510000@zion.home.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paolo 'Blaisorblade' Giarrusso (blaisorblade@yahoo.it) wrote:
> We were leaking pmd pages when 3_LEVEL_PGTABLES was enabled. This fixes that,
> has been well tested and is included in mainline tree. Please include in -stable
> as well.

Added to -stable queue.

thanks,
-chris

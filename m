Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUCWCug (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCWCug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:50:36 -0500
Received: from main.gmane.org ([80.91.224.249]:3804 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262182AbUCWCuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:50:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: 2.6.5-rc2-mm1
Date: Mon, 22 Mar 2004 18:43:04 -0800
Message-ID: <pan.2004.03.23.02.43.03.599787@triplehelix.org>
References: <20040321015412.491cd2cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004 01:54:12 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc2/2.6.5-rc2-mm1/

This kernel seems to hang after mounting the root filesystem (in my case
xfs) readonly, ie right before starting init. Is a fix for this ready or
in the works?

My .config is at http://triplehelix.org/~joshk/kernconf-darjeeling

-- 
Joshua Kwan



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269134AbUINC2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269134AbUINC2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269130AbUINC00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:26:26 -0400
Received: from holomorphy.com ([207.189.100.168]:7824 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269127AbUINCZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:25:33 -0400
Date: Mon, 13 Sep 2004 19:25:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [pidhashing] [0/3] pid allocator updates
Message-ID: <20040914022530.GO9106@holomorphy.com>
References: <20040913015003.5406abae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913015003.5406abae.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 01:50:03AM -0700, Andrew Morton wrote:
> Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
>  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
> and will later appear at
>  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/
> Please check kernel.org before using zip.com.au.

The following 3 updates address various issues expressed to me in
unrelated threads or messages, and while none of them are particularly
pressing each does resolve a concern I've deemed valid.


-- wli

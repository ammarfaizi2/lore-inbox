Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVAGGV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVAGGV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 01:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVAGGV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 01:21:28 -0500
Received: from zeus.kernel.org ([204.152.189.113]:57268 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261262AbVAGGVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 01:21:24 -0500
Date: Thu, 6 Jan 2005 22:20:31 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.6.10-mm2: move CPUSETS above EMBEDDED
Message-Id: <20050106222031.74595e5b.pj@sgi.com>
In-Reply-To: <20050106175707.GF3096@stusta.de>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<20050106175707.GF3096@stusta.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian wrote:
> The placement of CPUSETS somewhere in the middle of the EMBEDDED options 
> breaks the EMBEDDED submenu (at least in menuconfig).

Thanks for fixing this, Adrian.  I was ignorant of this config ordering.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVAaL6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVAaL6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVAaL6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:58:09 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:5058 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261159AbVAaL6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:58:07 -0500
Date: Mon, 31 Jan 2005 03:57:42 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
Message-Id: <20050131035742.1434944c.pj@sgi.com>
In-Reply-To: <20050131074400.GL2891@waste.org>
References: <20050131074400.GL2891@waste.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about just removing the self test, not "#if 0"'ing it out.

Better to keep the kernel source code clean of development
scaffolding.

Though your patch 1/8 hasn't arrived in my email inbox yet,
so I don't actually know what 'self test' code it is that
I am speaking of ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVC1GCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVC1GCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 01:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVC1GCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 01:02:49 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:60051 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261160AbVC1GCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 01:02:47 -0500
Date: Sun, 27 Mar 2005 22:01:53 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: ]PATCH] cpuset: make function decl. ANSI
Message-Id: <20050327220153.4aa3aace.pj@engr.sgi.com>
In-Reply-To: <20050327214226.72dc5a34.rddunlap@osdl.org>
References: <20050327214226.72dc5a34.rddunlap@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy wrote:
> kernel/cpuset.c:1428:41: warning: non-ANSI function declaration

Acked-by: Paul Jackson <pj@sgi.com>

Thanks, Randy.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

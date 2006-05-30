Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWE3Fjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWE3Fjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWE3Fjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:39:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60612 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750804AbWE3Fjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:39:43 -0400
Date: Mon, 29 May 2006 22:39:31 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org
Subject: Re: + for_each_cpu_mask-warning-fix.patch added to -mm tree
Message-Id: <20060529223931.7cc238a8.pj@sgi.com>
In-Reply-To: <200605300524.k4U5OA6R029592@shell0.pdx.osdl.net>
References: <200605300524.k4U5OA6R029592@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which is unpleasantly fixed by this:

Acked-by: Paul Jackson <pj@sgi.com>

Short of actually -using- the mask in the UP case,
which we prefer not to do for performance reasons,
I don't see anything better.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

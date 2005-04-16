Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVDPJBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVDPJBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 05:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVDPJBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 05:01:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42647 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261435AbVDPJBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 05:01:38 -0400
Date: Sat, 16 Apr 2005 01:59:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dvrabel@cantab.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: incoming
Message-Id: <20050416015958.268a3b06.pj@sgi.com>
In-Reply-To: <20050412041045.78e29f0e.akpm@osdl.org>
References: <20050412032322.72d73771.akpm@osdl.org>
	<425BAAB3.7070605@cantab.net>
	<20050412041045.78e29f0e.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> I never got around to setting that up, plus the Subject:s pretty quickly
> become invisible when they're indented 198 columns in GUI MUAs.

My sendpatchset tool should be good for this.  It sends all but the
first message are sent in "Reference" to, and "In-Reply-To" the first
message.

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

I use it when sending out multiple patches in sequence from a quilt
repository.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

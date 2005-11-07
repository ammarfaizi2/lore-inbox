Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVKGD56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVKGD56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVKGD56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:57:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11239 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932376AbVKGD55 (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 22:57:57 -0500
Date: Sun, 6 Nov 2005 19:57:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hch@infradead.org, Linux-Kernel@vger.kernel.org
Subject: Re: [rfc][patch 0/14] mm: performance improvements
Message-Id: <20051106195750.5cf71820.pj@sgi.com>
In-Reply-To: <436EB326.3070006@yahoo.com.au>
References: <436DBAC3.7090902@yahoo.com.au>
	<20051107013900.GA9170@infradead.org>
	<436EB326.3070006@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe time to switch mailers... I'll see what I can do.

I recommend using a dedicated tool (patchbomb script) to send patches,
not ones email client.  It lets you prepare everything ahead of time in
your favorite editor, and obtains optimum results.

See the script I use, at:

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

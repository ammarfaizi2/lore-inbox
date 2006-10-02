Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWJBQ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWJBQ1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWJBQ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:27:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60637 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965076AbWJBQ1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:27:48 -0400
Date: Mon, 2 Oct 2006 09:27:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH] usb hubc build fix.patch prefix
Message-Id: <20061002092737.7816b8f5.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.44L0.0610021003330.6651-100000@iolanthe.rowland.org>
References: <20061002023720.9780.85391.sendpatchset@v0>
	<Pine.LNX.4.44L0.0610021003330.6651-100000@iolanthe.rowland.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> There is no patch labelled usb-hubc-build-fix.patch anywhere in 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/
> This suggests that the quilt archive is indeed messed up.

Thanks - good observation.

I see the same thing here.  The 2.6.18-mm2-broken-out.tar.bz2 I downloaded from

  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/2.6.18-mm2-broken-out.tar.bz2

has a file named broken-out/usb-hubc-build-fix.patch, but the broken out directory

  ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/broken-out/

does not have such a file.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

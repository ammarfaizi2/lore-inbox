Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUF0XnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUF0XnA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUF0XnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 19:43:00 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:16031 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264540AbUF0Xm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 19:42:59 -0400
Date: Sun, 27 Jun 2004 16:43:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Inclusion of UML in 2.6.8
Message-Id: <20040627164332.6c86ccd2.pj@sgi.com>
In-Reply-To: <1088344199.21940.62.camel@winden.suse.de>
References: <200406261905.22710.blaisorblade_spam@yahoo.it>
	<20040626130945.190fb199.akpm@osdl.org>
	<20040627035923.GB8842@ccure.user-mode-linux.org>
	<20040626233253.06ed314e.pj@sgi.com>
	<20040626234025.7d69937c.akpm@osdl.org>
	<1088344199.21940.62.camel@winden.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> forgetting to add a file to a patch before modifying it is painful.

Yup.

One can dig ones way out by (1) copying the new code aside, (2)
unwinding until you can forcibly pop (or bk co) the pristine source
back, (3) push'ing back to the desired patch, (4) 'q edit' and copy over
the new code.  But this is a "learned" response.

> I do not have a good idea how to fix this in a more satisfactory way.

Me neither.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

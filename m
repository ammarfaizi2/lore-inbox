Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUG1X0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUG1X0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266780AbUG1XUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:20:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:28293 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266531AbUG1XMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:12:40 -0400
Date: Wed, 28 Jul 2004 16:13:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040728161333.744870b7.pj@sgi.com>
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
References: <20040728020444.4dca7e23.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The patch:

  gcc35-index.html.patch

in the broken-out patch set is _very_ trivial.
So much so that quilt complains:

  Only garbage was found in the patch input.

I trust I won't be missing much if I delete this
one from the series file ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

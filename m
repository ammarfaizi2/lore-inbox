Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUGEVmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUGEVmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUGEVmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 17:42:22 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:65470 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261184AbUGEVmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 17:42:21 -0400
Date: Mon, 5 Jul 2004 14:44:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Mark Adler <madler@alumni.caltech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-Id: <20040705144436.62544a3d.pj@sgi.com>
In-Reply-To: <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu>
References: <2e9is-5YT-1@gated-at.bofh.it>
	<2e9iu-5YT-5@gated-at.bofh.it>
	<2ecq2-80i-1@gated-at.bofh.it>
	<7ab39013.0407042237.40ea9035@posting.google.com>
	<20040705064010.C9BFB5F7AA@attila.bofh.it>
	<9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not a lawyer, but I don't see why you'd want the copyright notice
in the executable:

 * It's probably the source text that you're intending to copyright, not
   the binary executable bits.

 * If you look, I believe you will find that there are almost no other
   copyright strings in the vmlinux executable.

 * By what right can I copy or distribute a kernel built with this string
   in it?  The comments in zlib.h let us use the source, but I don't see
   any authorization to use the resulting executable bits on which this
   static copyright string seems to assert copyright.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUEZEhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUEZEhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUEZEhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:37:23 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:8028 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265287AbUEZEhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:37:22 -0400
Date: Tue, 25 May 2004 21:37:10 -0700
From: Paul Jackson <pj@sgi.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove message: POSIX conformance testing by UNIFIX
Message-Id: <20040525213710.5414f1a8.pj@sgi.com>
In-Reply-To: <20040525205820.25338dd5.rddunlap@osdl.org>
References: <20040525205820.25338dd5.rddunlap@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	printk("POSIX conformance testing by UNIFIX\n");

That's a stubborn line.  Andrew already tried to remove it
once, with a patch I believe he called:

  delete-posix-conformance-testing-by-unifix-message.patch

in his 2.6.6 *-mm series.  But that patch was neutered by
some glitch.

You're right - we have concensus on this change.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

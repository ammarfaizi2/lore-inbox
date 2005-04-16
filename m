Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVDPJFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVDPJFE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 05:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDPJFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 05:05:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17560 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261458AbVDPJFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 05:05:00 -0400
Date: Sat, 16 Apr 2005 02:03:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: geert@linux-m68k.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: incoming
Message-Id: <20050416020314.360a0523.pj@sgi.com>
In-Reply-To: <1113493092.18479.7.camel@mindpipe>
References: <20050412032322.72d73771.akpm@osdl.org>
	<Pine.LNX.4.62.0504141347500.19995@numbat.sonytel.be>
	<1113493092.18479.7.camel@mindpipe>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like Andrew's patch bomb script needs some rate limiting ;-)

sendpatchset has that, already builtin ;)

	http://www.speakeasy.org/~pj99/sgi/sendpatchset

Though the 5 second delay might not be enough for someone
publishing at the rate Andrew does.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401

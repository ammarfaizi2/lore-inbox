Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVA1FTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVA1FTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 00:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVA1FTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 00:19:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:51126 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261459AbVA1FTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 00:19:05 -0500
Date: Thu, 27 Jan 2005 21:18:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
Message-Id: <20050127211839.6f73a4db.pj@sgi.com>
In-Reply-To: <20050128042815.GA29751@elte.hu>
References: <20041116113209.GA1890@elte.hu>
	<419A7D09.4080001@bigpond.net.au>
	<20041116232827.GA842@elte.hu>
	<Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
	<20050127165330.6f388054.pj@sgi.com>
	<20050128042815.GA29751@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> if by 'some CPUs' you mean x86 then it's the LOCK prefixed ops ...

Yup - that's the one.  Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401

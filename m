Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268697AbUIQLbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268697AbUIQLbm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUIQLaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:30:55 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10215 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268697AbUIQL3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:29:12 -0400
Date: Fri, 17 Sep 2004 04:28:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Stelian Pop <stelian@popies.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-Id: <20040917042831.253fe8df.pj@sgi.com>
In-Reply-To: <20040917102413.GA3089@crusoe.alcove-fr>
References: <20040913135253.GA3118@crusoe.alcove-fr>
	<20040915153013.32e797c8.akpm@osdl.org>
	<20040916064320.GA9886@deep-space-9.dsnet>
	<20040916000438.46d91e94.akpm@osdl.org>
	<20040916104535.GA3146@crusoe.alcove-fr>
	<20040916100050.17a9b341.akpm@osdl.org>
	<20040916180908.GB9886@deep-space-9.dsnet>
	<20040916171817.78ab4430.akpm@osdl.org>
	<20040917102413.GA3089@crusoe.alcove-fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian wrote:
> A third and I hope final version of the patch follows.

The struct kfifo is quite a bit more readable - nice.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

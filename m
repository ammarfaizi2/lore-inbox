Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUGQUuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUGQUuo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUGQUuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:50:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:40613 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbUGQUun (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:50:43 -0400
Date: Sat, 17 Jul 2004 12:34:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
Message-Id: <20040717123443.18065893.akpm@osdl.org>
In-Reply-To: <40F9854D.2000408@comcast.net>
References: <40F9854D.2000408@comcast.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman <safemode@comcast.net> wrote:
>
> Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
> writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
> data cds write as expected, but audio cds will cause (at any speed) the 
> box to start using insane amounts of swap (>150MB) and eventually cause 
> the box to crash before finishing the cd.

What is the full cdrecord command line?

Were earlier kernels OK?

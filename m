Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUEAKcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUEAKcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 06:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEAKcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 06:32:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:12340 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262132AbUEAKcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 06:32:41 -0400
Date: Sat, 1 May 2004 03:36:12 -0700
From: Paul Jackson <pj@sgi.com>
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large page support in the Linux Kernel?
Message-Id: <20040501033612.0078b26f.pj@sgi.com>
In-Reply-To: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
References: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was wondering if there is going to be large page support for the linux
> kernel in the near future.

Do a search in this lkml for "hugetlb",  and read the linux file
Documentation/vm/hugetlbpage.txt.  Is that what you're looking for?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

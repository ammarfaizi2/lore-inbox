Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWEBH6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWEBH6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWEBH6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:58:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27094 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932494AbWEBH6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:58:52 -0400
Subject: Re: [RFC] kernel facilities for cache prefetching
From: Arjan van de Ven <arjan@infradead.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <20060502075049.GA5000@mail.ustc.edu.cn>
References: <20060502075049.GA5000@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Tue, 02 May 2006 09:58:44 +0200
Message-Id: <1146556724.32045.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> PREVIOUS WORKS
> 
> 	There has been some similar efforts, i.e.
> 		- Linux: Boot Time Speedups Through Precaching
> 		  http://kerneltrap.org/node/2157
> 		- Andrew Morton's kernel module solution
> 		  http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> 		- preload - adaptive readahead daemon
> 		  http://sourceforge.net/projects/preload

you missed the solution Fedora deploys since over a year using readahead




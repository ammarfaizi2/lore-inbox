Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWEBIGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWEBIGK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 04:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWEBIGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 04:06:10 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:1450 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932501AbWEBIGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 04:06:08 -0400
Message-ID: <346557165.30752@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 2 May 2006 16:06:19 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502080619.GA5406@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <1146556724.32045.19.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146556724.32045.19.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 09:58:44AM +0200, Arjan van de Ven wrote:
> 
> > 
> > PREVIOUS WORKS
> > 
> > 	There has been some similar efforts, i.e.
> > 		- Linux: Boot Time Speedups Through Precaching
> > 		  http://kerneltrap.org/node/2157
> > 		- Andrew Morton's kernel module solution
> > 		  http://www.zip.com.au/~akpm/linux/fboot.tar.gz
> > 		- preload - adaptive readahead daemon
> > 		  http://sourceforge.net/projects/preload
> 
> you missed the solution Fedora deploys since over a year using readahead

Thanks, and sorry for more previous works that I failed to mention here :)

Wu

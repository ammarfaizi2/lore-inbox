Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTIBAPH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbTIBAPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:15:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:14787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263351AbTIBAPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:15:04 -0400
Date: Mon, 1 Sep 2003 17:14:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mfedyk@matchmail.com, superchkn@sbcglobal.net, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: -mm patches on www.kernel.org ?
Message-Id: <20030901171435.1ef05cc8.akpm@osdl.org>
In-Reply-To: <3F53DEE1.5000709@zytor.com>
References: <Pine.LNX.4.51.0308071636100.31463@dns.toxicfilms.tv>
	<20030901211108.GE31760@matchmail.com>
	<3F53B937.10103@sbcglobal.net>
	<20030901225339.GH31760@matchmail.com>
	<3F53DEE1.5000709@zytor.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
> Mike Fedyk wrote:
> > On Mon, Sep 01, 2003 at 04:25:11PM -0500, Wes Janzen wrote:
> > 
> >>I think he's saying, why not put a link to the mm kernels from the 
> >>www.kernel.org homepage, just like the ac kernels...  At least that's 
> >>how I read it.
> > 
> > Ok, then I can agree with that.
> 
> Can't do it.  The -mm kernels aren't a single patch, they're patch sets, 
> and they won't work with the system that we have set up.  If akpm wants 
> to make a unified patch for each patch set in addition to the set itself 
> then it can be done.
> 

Well I always have a full rollup there, such as

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm4/2.6.0-test4-mm4.gz

Is that what you mean?

(It would be good to add -aa patchsets too).

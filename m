Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbTI2Rqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTI2Rqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:46:34 -0400
Received: from [193.138.115.2] ([193.138.115.2]:51210 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263985AbTI2Rpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:45:31 -0400
Date: Mon, 29 Sep 2003 19:44:39 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: John Cherry <cherry@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6 (compile statistics)
In-Reply-To: <1064853054.914.5.camel@cherrytest.pdx.osdl.net>
Message-ID: <Pine.LNX.4.56.0309291937350.12255@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
 <1064853054.914.5.camel@cherrytest.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Sep 2003, John Cherry wrote:

> Linux 2.6 Compile Statistics (gcc 3.2.2)
> ----------------------------------------
>
> Warnings/Errors Summary
>
> Kernel         bzImage    bzImage  modules  bzImage   modules
>              (defconfig)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- ---------
> 2.6.0-test6    0w/0e      188w/ 1e  12w/0e   3w/0e    260w/ 2e
> 2.6.0-test5    0w/0e      205w/ 9e  15w/1e   0w/0e    305w/ 5e
> 2.6.0-test4    0w/0e      797w/55e  68w/1e   3w/0e   1016w/34e
> 2.6.0-test3    0w/0e      755w/66e  62w/1e   7w/9e    984w/42e
> 2.6.0-test2    0w/0e      952w/65e  63w/2e   7w/9e   1201w/43e
> 2.6.0-test1    0w/0e     1016w/60e  75w/1e   8w/9e   1319w/38e
>

I was wondering if there would be any point in doing these builds with
"allnoconfig" as well?
Could this possibly flush out some warnings/errors that only occur when
something is left out?


/Jesper Juhl


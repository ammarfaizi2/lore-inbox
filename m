Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbTEMOsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbTEMOsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:48:00 -0400
Received: from havoc.daloft.com ([64.213.145.173]:31954 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261311AbTEMOr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:47:56 -0400
Date: Tue, 13 May 2003 11:00:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513150042.GA21126@gtf.org>
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 02:57:08PM +0100, Alan Cox wrote:
> On Llu, 2003-05-12 at 23:55, Andrew Morton wrote:
> > 
> > - IDE tcq. Either kill it or fix it. Not a "big todo", as such.
> > 
> 
> There are lots of other IDE bugs that wont go away until the taskfile
> stuff is included,

Let me ask the dumb question then.  :)  I've been following the various
IDE threads and see a lot of "X won't happen until taskfile IO is in"

What remains to do, until taskfile IO can go in?

Thanks,

	Jeff




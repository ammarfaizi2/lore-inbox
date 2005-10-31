Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVJaIry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVJaIry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVJaIry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:47:54 -0500
Received: from smtpout6.uol.com.br ([200.221.4.197]:17347 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S932077AbVJaIrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:47:53 -0500
Date: Mon, 31 Oct 2005 06:47:48 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: Rob Landley <rob@landley.net>, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       torvalds@osdl.org, tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051031084748.GB3087@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Rob Landley <rob@landley.net>, ak@suse.de,
	rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, tony.luck@gmail.com,
	paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051030111241.74c5b1a6.akpm@osdl.org> <200510310148.57021.ak@suse.de> <200510302305.46532.rob@landley.net> <20051030231723.71c72865.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051030231723.71c72865.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30 2005, Andrew Morton wrote:
> But the cc'ed people just _have_ to take time out to read the dang
> patch!  They almost always have multiple weeks in which to do this.
> But if they just delete the thing while they work on their own stuff,
> well...

Indeed. And there are the guinea pigs/lusers like me that are willing to
test and do some roundtrips of reports to get the kernel working better
(with the little that I can help). :-)

Now that I have backups working as I wanted, I surely intend to give the
-mm tree more tries.

Oh, and I would really appreciate if some options had at least some
description when I do a make menuconfig. Would identifying these options
or asking for clarification of others be of any interest?

I do think that they would help me when I try to compile the kernel for
some of my friends' computers.


Thanks, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/

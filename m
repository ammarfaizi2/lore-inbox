Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUBQON1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 09:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUBQON0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 09:13:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:6287 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266172AbUBQONZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 09:13:25 -0500
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
	JFS default behavior)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Marc Lehmann <pcg@schmorp.de>
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040216205835.GG17015@schmorp.de>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca>
	 <200402150006.23177.robin.rosenberg.lists@dewire.com>
	 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
	 <200402150107.26277.robin.rosenberg.lists@dewire.com>
	 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
	 <20040216183616.GA16491@schmorp.de>
	 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org>
	 <20040216200321.GB17015@schmorp.de>
	 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org>
	 <20040216205835.GG17015@schmorp.de>
Content-Type: text/plain
Message-Id: <1077027146.4534.26.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 17 Feb 2004 08:12:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 14:58, Marc Lehmann wrote:

> True. Thanks a lot for explaining your arguments in this detail. In
> fact, I can accept most if not all of your arguments, but I sitll think
> it would be nice to have this extra functionality.
> 
> Arguments like "it's a pain to implement" (which I don't think it is, but
> you are clearly better in judging that!), weigh even more to me.
> 
> So even if I think it's a good idea, it might never be implemneted for
> purely practical reasons.

Use jfs with the mount option iocharset=utf8 and you'll get exactly what
you are asking for.

-- 
David Kleikamp
IBM Linux Technology Center


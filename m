Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTL1WIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 17:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTL1WIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 17:08:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:13960 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbTL1WIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 17:08:12 -0500
Date: Sun, 28 Dec 2003 14:02:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Michael Still <mikal@stillhq.com>
Cc: tmolina@cablespeed.com, akpm@osdl.org, linux-kernel@n-dimensional.de,
       linux-kernel@vger.kernel.org
Subject: Re: Fixing 2.6.0's broken documentation references
Message-Id: <20031228140220.718f2e91.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0312282145070.18079-100000@diskbox.stillhq.com>
References: <Pine.LNX.4.58.0312272222500.14915@localhost.localdomain>
	<Pine.LNX.4.44.0312282145070.18079-100000@diskbox.stillhq.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 21:48:57 +1100 (EST) Michael Still <mikal@stillhq.com> wrote:

| On Sat, 27 Dec 2003, Thomas Molina wrote:
| 
| > I agree that having a documentation maintainer would be a good idea.  Hans 
| > could volunteer or I could if no one else wants it.  Whoever does it 
| > though, needs some assurance that patches won't be dropped on the floor.
| 
| I would think that any such maintainer would also have to deal with 
| kernel-doc, and making sure all of those scripts work / don't produce 
| errors. I got a bunch of patches into the late 2.5 cycle to deal with 
| that, but someone needs to keep that stuff working.
| 
| I'm happy to keep playing with those scripts, if other people are happy 
| with that.
| 
| My point is that documentation is more complex than just keeping the 
| comments in the source pointing at the right places -- there is a bunch of 
| infrastructure there as well.
| 
| On the dropped patch front, I had a lot of success getting patches into 
| the kernel via the Trivial Patch Monkey. Given the menial nature of this 
| sort of work, wouldn't this best be done by the janitors and sending 
| patches to trivial?

I agree, using kernel-janitors or trivial patch monkey should be
sufficient and acceptable.

--
~Randy

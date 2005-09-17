Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVIQChw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVIQChw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 22:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVIQChw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 22:37:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15018 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750831AbVIQChv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 22:37:51 -0400
Date: Fri, 16 Sep 2005 19:37:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Fix epoll delayed initialization bug ...
Message-Id: <20050916193741.74f5a830.pj@sgi.com>
In-Reply-To: <20050916165053.2dec0a6b.akpm@osdl.org>
References: <Pine.LNX.4.63.0509161621050.6125@localhost.localdomain>
	<20050916165053.2dec0a6b.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew complained:
> The number of whitespace-buggered patches which are coming in is just
> getting out of control lately.

If people didn't use email clients, but rather a patch sending script,
it would work better.  It is easier to send patch sets this way (you get
to edit all the vital fields, such as Subject, To and Cc lists, in your
favorite text editor), and the usual failures that mess up patch
sending are avoided.

The script I'm using is in good shape, and several others besides
myself are successfully using it to send patches to lkml.

See the embedded Usage string for documentation.

  http://www.speakeasy.org/~pj99/sgi/sendpatchset

It handles sending one or several related patches, to a list of email
addresses.  You prepare a text directive file with the addresses,
subjects and pathnames to the files containing the message contents.
Then you send it all off with a single invocation of this 'sendpatchset'
script.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

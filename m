Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVKVJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVKVJTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKVJTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:19:23 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:58049 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751069AbVKVJTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:19:23 -0500
Date: Tue, 22 Nov 2005 01:18:45 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Frost <artusemrys@sbcglobal.net>
Cc: marc@osknowledge.org, rostedt@goodmis.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       xose.vazquez@gmail.com
Subject: Re: [RFC] Documentation dir is a mess
Message-Id: <20051122011845.32bab1d6.pj@sgi.com>
In-Reply-To: <20051122060648.8827.qmail@web81904.mail.mud.yahoo.com>
References: <20051121173404.GA7886@stiffy.osknowledge.org>
	<20051122060648.8827.qmail@web81904.mail.mud.yahoo.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The documents
> that exist may not conform themselves well to that sort of division,
> necessarily.

Good point, not just for -that- sort of division, but perhaps for
any sort.

I am skeptical that there is much value to be added to the current
hodge podge of documents in the Documentation directory by rearranging
them in some grand scheme.

Certainly there is some value that can be subtracted -- just changing
it will result in some minor cost to each of us, adjusting to the
changes.  The greater the changes, the more aggressive the effort to
categorize it, the greater this distributed cost of change.

Perhaps what we have is deeper than just improperly arranged Docs.
The content of the Docs may have too much variation in depth, topic,
breadth, organization, style and such to be well suited to a deep
structure.

Maybe it looks disorganized because it is -- more than just skin deep.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUBNFyN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 00:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUBNFyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 00:54:13 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:24246 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264898AbUBNFyM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 00:54:12 -0500
Date: Fri, 13 Feb 2004 21:54:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Larry McVoy <lm@bitmover.com>, Bryan Whitehead <driver@jpl.nasa.gov>,
       M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040214055404.GA25465@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
	Bryan Whitehead <driver@jpl.nasa.gov>, M?ns Rullg?rd <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <20040211161358.GA11564@favonius> <yw1xisidino2.fsf@kth.se> <402A747C.8020100@jpl.nasa.gov> <20040211191922.GA31404@work.bitmover.com> <402AD1A7.3020000@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402AD1A7.3020000@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 05:06:47PM -0800, Hans Reiser wrote:
> Will you have any chance of extremely large directories?  Do you or your 
> users determine the maximum size of directories?

We don't have that problem.  Imagine 500 clones of the Linux kernel all of
which are at least somewhat active on one disk arm.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com

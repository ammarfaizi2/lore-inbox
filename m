Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269304AbUH0DDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269304AbUH0DDb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 23:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269378AbUHZSxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:53:12 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:25910 "EHLO
	mwinf1003.wanadoo.fr") by vger.kernel.org with ESMTP
	id S269317AbUHZSnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:43:06 -0400
Subject: Re: silent semantic changes with reiser4
From: Thomas Cataldo <tomc@compaqnet.fr>
To: Christoph Hellwig <hch@lst.de>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
In-Reply-To: <20040826093407.GB28854@lst.de>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com>
	 <20040826093407.GB28854@lst.de>
Content-Type: text/plain
Date: Thu, 26 Aug 2004 20:40:27 +0200
Message-Id: <1093545627.11770.2.camel@buffy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 11:34 +0200, Christoph Hellwig wrote:
> On Thu, Aug 26, 2004 at 01:31:34AM -0700, Hans Reiser wrote:
> > Andrew, we need to compete with WinFS and Dominic Giampaolo's filesystem 
> > for Apple, and that means we need to put search engine and database 
> 
> Dou you know a nice thing?  We (as in the Linux Community) don't have to
> compete with anyone.  Sure, we're usually trying to be better than
> anyone else, but unlike companies under maret pressure we can wait until
> something is ready.

By the way, this kind of features can be achieved easily in userspace
with, for example, ext3, beagle (a userspace fulltext indexing daemon)
and some (d|i)notify magic.



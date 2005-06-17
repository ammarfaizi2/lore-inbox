Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVFQVlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVFQVlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVFQVlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 17:41:07 -0400
Received: from peabody.ximian.com ([130.57.169.10]:10396 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262104AbVFQVkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 17:40:39 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Christoph Hellwig <hch@lst.de>,
       arnd@arndb.de, zab@zabbo.net, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <20050617143334.41a31707.akpm@osdl.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175605.GB1981@tentacle.dhs.org>
	 <20050617143334.41a31707.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 17:40:30 -0400
Message-Id: <1119044430.7280.22.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 14:33 -0700, Andrew Morton wrote:

> So.  It's not too late.  Please spend an hour and write up the Inofity
> Implementation FAQ?  You probably remember and fully understand what all of
> our objections are and I know that you have explanations and rebuttals at
> hand.

I wrote this up the first time you asked:

	Documentation/filesystems/inotify.txt

It sounds like its never been addressed because some people don't take
different views as an acceptable solution.

	Robert Love



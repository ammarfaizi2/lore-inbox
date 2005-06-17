Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVFQSRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVFQSRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 14:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVFQSRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 14:17:06 -0400
Received: from peabody.ximian.com ([130.57.169.10]:667 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262043AbVFQSQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 14:16:54 -0400
Subject: Re: [patch] inotify.
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Zach Brown <zab@zabbo.net>,
       linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050617175404.GA19463@infradead.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net>
	 <1118946334.3949.63.camel@betsy> <200506171907.39940.arnd@arndb.de>
	 <20050617175404.GA19463@infradead.org>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 14:16:53 -0400
Message-Id: <1119032213.3949.124.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 18:54 +0100, Christoph Hellwig wrote:

> It's because Robert and John insist on their horrible interface and
> simply ignore any feedback on how to do a better one.

We considered your feedback, Christoph.  Ultimately, John, Andrew, and I
settled on the current approach.  In life, not everyone agrees on every
little detail and there usually exists a large difference between "not
exactly the same" and "horrible".  And never does the histrionics result
in anything productive.

	Robert Love



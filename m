Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWAQUun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWAQUun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWAQUun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:50:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25790 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964830AbWAQUum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:50:42 -0500
Date: Tue, 17 Jan 2006 12:50:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: schwidefsky@de.ibm.com, ric@emc.com, hch@lst.de, arnd@arndb.de,
       linux-kernel@vger.kernel.org, saparnis_carol@emc.com
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
Message-Id: <20060117125013.1d51d211.akpm@osdl.org>
In-Reply-To: <20060117133523.GA27322@lst.de>
References: <20051216143348.GB19541@lst.de>
	<20060106110157.GA16725@lst.de>
	<43BE7C45.4090206@emc.com>
	<20060106142146.GA20094@lst.de>
	<43BE7EE4.3010203@emc.com>
	<1136970987.6147.14.camel@localhost.localdomain>
	<20060117133523.GA27322@lst.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 11, 2006 at 10:16:27AM +0100, Martin Schwidefsky wrote:
> > The patch we got from EMC is for 2.4 and in its current form would never
> > have worked for 2.6 anyway. So 2.6 is already broken, no reason to hold
> > off the ioctl removal patch. We'll come up with a cleaned up solution.
> > 
> > Christoph, please go ahead and push the patch to Andrew. 
> 
> Andrew, should I resend the two patches or can you grab them from the
> mbox?

I found them, and they still seem to apply.

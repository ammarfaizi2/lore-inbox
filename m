Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbUB0Wx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUB0WwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:52:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:36237 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263178AbUB0Wv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:51:27 -0500
Subject: Re: Linux hotplug memory mailing list created
From: Dave Hansen <haveblue@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       linux-hotplug-memory@lists.sourceforge.net
In-Reply-To: <200402272334.17554.arnd@arndb.de>
References: <20040227215349.GA12122@kroah.com>
	 <200402272334.17554.arnd@arndb.de>
Content-Type: text/plain
Message-Id: <1077922274.19657.140.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 14:51:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 14:34, Arnd Bergmann wrote:
> On Friday 27 February 2004 22:53, Greg KH wrote:
> 
> > As I personally know of at least 3 different groups at 3 different
> > companies working on this feature, and all of them don't seem to want to
> > talk together on linux-kernel or linux-mm, this list is for them, and
> > anyone else who wants to help.
> 
> Does this already include the s390 kernel team? We are definitely
> interested in this. Note that we already have one (rather limited)
> solution for memory unplug in arch/s390/mm/cmm.c, but this is far
> from real memory hotplug and uses an architecture feature that is
> probably not available anywhere else.

I don't think I knew about s390, at least.  That makes 4 :)  I don't see
arch/s390/mm/cmm.c in 2.6.3.  Is it in another tree?


-- dave


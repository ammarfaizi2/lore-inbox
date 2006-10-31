Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423801AbWJaTI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423801AbWJaTI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423805AbWJaTI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:08:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:25259 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423801AbWJaTI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:08:28 -0500
Date: Tue, 31 Oct 2006 11:07:54 -0800
From: Greg KH <gregkh@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061031190754.GA15413@suse.de>
References: <45463481.80601@shadowen.org> <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com> <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com> <1162277642.5970.4.camel@Homer.simpson.net> <20061031071347.GA7027@suse.de> <1162278909.6416.5.camel@Homer.simpson.net> <20061031072145.GA7306@suse.de> <1162279873.6416.11.camel@Homer.simpson.net> <1162281794.9664.1.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162281794.9664.1.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:03:14AM +0100, Mike Galbraith wrote:
> On Tue, 2006-10-31 at 08:31 +0100, Mike Galbraith wrote:
> > On Mon, 2006-10-30 at 23:21 -0800, Greg KH wrote:
> >  
> > > Crap, the libsysfs hooks were more intrusive than I expected.  10.2
> > > should not have this issue anymore.  Until then, just enable that config
> > > option and you should be fine.
> > 
> > I just grabbed latest sysfsutils and configutils srpms, and will see if
> > the problem has been fixed yet.
> > 
> > (oh... gregkh@suse.de.  i guess you're already sure:)
> 
> (i tested it anyway, and of course you're right, it's fixed)

Thanks for verifying this, I appreciate it.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946609AbWKAGMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946609AbWKAGMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 01:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946603AbWKAGMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 01:12:24 -0500
Received: from mail.gmx.de ([213.165.64.20]:32948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1946609AbWKAGMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 01:12:23 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <20061031212508.1b116655.akpm@osdl.org>
References: <45461977.3020201@shadowen.org> <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <20061031065912.GA13465@suse.de>
	 <1162278594.6416.4.camel@Homer.simpson.net> <20061031072241.GB7306@suse.de>
	 <1162312126.5918.12.camel@Homer.simpson.net>
	 <1162318477.6016.3.camel@Homer.simpson.net>
	 <1162356198.6105.18.camel@Homer.simpson.net>
	 <20061031212508.1b116655.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 07:12:09 +0100
Message-Id: <1162361529.5899.1.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 21:25 -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 05:43:18 +0100
> Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Tue, 2006-10-31 at 19:14 +0100, Mike Galbraith wrote:
> > 
> > > Seems it's driver-core-fixes-sysfs_create_link-retval-checks-in.patch
> > > 
> > > Tomorrow, I'll revert that alone from 2.6.19-rc3-mm1 to confirm...
> > 
> > Confirmed.  Boots fine with that patch reverted.
> 
> Could you test with something like this applied?

No output.  I had already enabled debugging, but got nada there either.
Bugger.  <scritch scritch>

	-Mike


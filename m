Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUGFGLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUGFGLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 02:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUGFGLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 02:11:52 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:17807 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S263107AbUGFGLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 02:11:51 -0400
Date: Tue, 6 Jul 2004 08:11:50 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mark Adler <madler@alumni.caltech.edu>
Cc: Jesse Stockall <stockall@magma.ca>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-ID: <20040706061149.GA3557@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mark Adler <madler@alumni.caltech.edu>,
	Jesse Stockall <stockall@magma.ca>, Paul Jackson <pj@sgi.com>,
	linux-kernel@vger.kernel.org
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it> <2ecq2-80i-1@gated-at.bofh.it> <7ab39013.0407042237.40ea9035@posting.google.com> <20040705064010.C9BFB5F7AA@attila.bofh.it> <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu> <20040705144436.62544a3d.pj@sgi.com> <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu> <1089085868.8452.2.camel@localhost> <1820F1EE-CF07-11D8-B083-000A95820F30@alumni.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1820F1EE-CF07-11D8-B083-000A95820F30@alumni.caltech.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 09:43:58PM -0700, Mark Adler wrote:
> On Jul 5, 2004, at 8:51 PM, Jesse Stockall wrote:
> >Did I miss something or are you saying that the version in the kernel
> >has a security vulnerability?
> 
> If the kernel has 1.1.3, then yes.  You can get 1.1.4 here, which 
> remedies that vulnerability:

I seem to recall that vulnerability was fixed in place, without upgrading to
1.1.4.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

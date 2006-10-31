Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422918AbWJaIDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422918AbWJaIDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWJaIDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:03:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:13265 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422918AbWJaIDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:03:44 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: "Martin J. Bligh" <mbligh@google.com>,
       Cornelia Huck <cornelia.huck@de.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
In-Reply-To: <1162279873.6416.11.camel@Homer.simpson.net>
References: <45461E74.1040408@google.com>
	 <20061030084722.ea834a08.akpm@osdl.org> <454631C1.5010003@google.com>
	 <45463481.80601@shadowen.org>
	 <20061030211432.6ed62405@gondolin.boeblingen.de.ibm.com>
	 <1162276206.5959.9.camel@Homer.simpson.net> <4546EF3B.1090503@google.com>
	 <1162277642.5970.4.camel@Homer.simpson.net> <20061031071347.GA7027@suse.de>
	 <1162278909.6416.5.camel@Homer.simpson.net> <20061031072145.GA7306@suse.de>
	 <1162279873.6416.11.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:03:14 +0100
Message-Id: <1162281794.9664.1.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 08:31 +0100, Mike Galbraith wrote:
> On Mon, 2006-10-30 at 23:21 -0800, Greg KH wrote:
>  
> > Crap, the libsysfs hooks were more intrusive than I expected.  10.2
> > should not have this issue anymore.  Until then, just enable that config
> > option and you should be fine.
> 
> I just grabbed latest sysfsutils and configutils srpms, and will see if
> the problem has been fixed yet.
> 
> (oh... gregkh@suse.de.  i guess you're already sure:)

(i tested it anyway, and of course you're right, it's fixed)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266792AbTGKVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbTGKVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:04:59 -0400
Received: from CPE-65-29-18-15.mn.rr.com ([65.29.18.15]:35261 "EHLO
	www.enodev.com") by vger.kernel.org with ESMTP id S266792AbTGKVEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:04:52 -0400
Subject: Re: 2.5 'what to expect'
From: Shawn <core@enodev.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0F23CF.6010406@didntduck.org>
References: <20030711140219.GB16433@suse.de>
	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
	 <3F0F23CF.6010406@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057958368.19648.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 16:19:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Or just run gentoo... ;) (sorry Alan)

On Fri, 2003-07-11 at 15:53, Brian Gerst wrote:
> Alan Cox wrote:
> >>- Some people seem to have trouble running rpm, most notably Red Hat 9 users.
> >>  This is a known bug of rpm.
> >>  Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.
> > 
> > 
> > or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
> > fixes a load of other problems) - ftp.rpm.org
> > 
> 
> Still fails with rpm 4.2.1 from rawhide without the LD_ASSUME_KERNEL 
> hack.  I haven't checked rpm.org yet, that site appears to be dead.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUHJUO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUHJUO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUHJUNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:13:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:37032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267701AbUHJUMY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:12:24 -0400
Date: Tue, 10 Aug 2004 13:12:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040810131217.Q1924@build.pdx.osdl.net>
References: <20040810130009.P1924@build.pdx.osdl.net> <Xine.LNX.4.44.0408101607170.9332-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408101607170.9332-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Tue, Aug 10, 2004 at 04:07:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Tue, 10 Aug 2004, Chris Wright wrote:
> > Is this new (i.e. you just did this)?  It's basically the same result we
> > had from a few years ago.
> 
> Yes, did it today.

Thanks, James.  Since these are the only concrete numbers and they are
in the noise, I see no compelling reason to change to unlikely().

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

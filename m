Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268651AbUHLSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268651AbUHLSSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268649AbUHLSRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:17:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:62428 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268648AbUHLSRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:17:21 -0400
Date: Thu, 12 Aug 2004 11:17:18 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Kurt Garloff <kurt@garloff.de>, Chris Wright <chrisw@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040812111718.M1924@build.pdx.osdl.net>
References: <20040811222213.GB14744@tpkurt.garloff.de> <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0408112120320.15343-100000@dhcp83-76.boston.redhat.com>; from jmorris@redhat.com on Wed, Aug 11, 2004 at 09:23:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Thu, 12 Aug 2004, Kurt Garloff wrote:
> 
> > The rest of the path is still a win IMVHO.
> > 
> > Unfortunately, it has not been discussed here yet.
> 
> Defaulting to the capability module is a separate discussion.  I
> personally don't have a strong opinion on this issue.

I've considering doing something like this.  Any chance you could
separate that bit of the patch out to work with?

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

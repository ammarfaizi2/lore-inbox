Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVCKQlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVCKQlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVCKQly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:41:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261195AbVCKQja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:39:30 -0500
Date: Fri, 11 Mar 2005 08:39:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, stable@kernel.org,
       Gred Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org,
       Josh Boyer <jdub@us.ibm.com>
Subject: Re: [stable] Re: [01/11] fix amd64 2.6.11 oops on modprobe (saa7110)
Message-ID: <20050311163905.GA5389@shell0.pdx.osdl.net>
References: <20050310230519.GA22112@kroah.com> <20050310230753.GB22112@kroah.com> <1110505061.8075.3.camel@windu.rchland.ibm.com> <20050311075723.GB29099@kroah.com> <20050311101358.79d216e7.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311101358.79d216e7.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jean Delvare (khali@linux-fr.org) wrote:
> Hi Greg, all,
> 
> > > Not that I really care, but isn't there a rule that a patch "... can
> > > not contain any "trivial" fixes in it (spelling changes, whitespace
> > > cleanups, etc.)"?
> > 
> > Good point.  Jean, care to respin the patch?
> 
> Sure, sorry for the trouble.

Thanks, updated patch.
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVELGcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVELGcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVELGcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:32:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:41921 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261209AbVELGcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:32:14 -0400
Date: Wed, 11 May 2005 23:32:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.11.9
Message-ID: <20050512063203.GE27549@shell0.pdx.osdl.net>
References: <20050511225448.GA12357@kroah.com> <4282F562.7020904@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4282F562.7020904@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michal Schmidt (xschmi00@stud.feec.vutbr.cz) wrote:
> Greg KH wrote:
> >Summary of changes from v2.6.11.8 to v2.6.11.9
> >==============================================
> >[...]
> >Jean Delvare:
> >  o I2C: Fix incorrect sysfs file permissions in it87 and via686a
> >    drivers
> 
> This was already in 2.6.11.8, wasn't it?

Yes.  There was a mixup, and the msdos partitions patch got mixed with
this one (in 2.6.11.8).  So that whole cset was backed out, and this
fix was reapplied in 2.6.11.9.

thanks,
-chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbVHaPJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbVHaPJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVHaPJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:09:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964830AbVHaPJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:09:32 -0400
Date: Wed, 31 Aug 2005 08:09:14 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050831150914.GD7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain> <20050831063433.GC28960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050831063433.GC28960@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Aug 24, 2005 at 06:20:33PM -0700, Chris Wright wrote:
> > Now that capability functions are default, rootplug no longer needs to
> > manually add them to its security_ops.
> > 
> > Cc: Greg Kroah <greg@kroah.com>
> > Signed-off-by: Chris Wright <chrisw@osdl.org>
> 
> You can add:
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> to this one when you send it on.

Thanks, will do.
-chris

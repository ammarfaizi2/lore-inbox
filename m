Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVCZJ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVCZJ2H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 04:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCZJ2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 04:28:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:7623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbVCZJ2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 04:28:04 -0500
Date: Sat, 26 Mar 2005 01:27:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.6
Message-ID: <20050326092753.GB30522@shell0.pdx.osdl.net>
References: <20050326033939.GV30522@shell0.pdx.osdl.net> <E1DF70M-0001ai-8z@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DF70M-0001ai-8z@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Moritz Muehlenhoff (jmm@inutil.org) wrote:
> In gmane.linux.kernel, you wrote:
> > With some pending security fixes it's time to for a -stable update.  So,
> > here's 2.6.11.6, in the normal kernel.org places.  This includes some
> > security fixes, esp. one which closes a local root exploit in bluetooth.
> 
> Could you please add CAN IDs to the stable changelog for already assigned
> vulnerabilities?

That's what I did for .5 -> .6.  We can't retroactively update changeset
comments, and I'm not sure we have any other candidates in -stable.
We'll certainly continue to add them as we have them.

thanks,
-chris

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVC0UAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVC0UAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVC0UAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:00:11 -0500
Received: from fire.osdl.org ([65.172.181.4]:15030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261503AbVC0UAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:00:06 -0500
Date: Sun, 27 Mar 2005 11:59:58 -0800
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>, Moritz Muehlenhoff <jmm@inutil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.6
Message-ID: <20050327195958.GJ30522@shell0.pdx.osdl.net>
References: <20050326033939.GV30522@shell0.pdx.osdl.net> <E1DF70M-0001ai-8z@localhost.localdomain> <20050326092753.GB30522@shell0.pdx.osdl.net> <20050327185259.GD5164@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327185259.GD5164@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ryan Anderson (ryan@michonline.com) wrote:
> On Sat, Mar 26, 2005 at 01:27:53AM -0800, Chris Wright wrote:
> > > Could you please add CAN IDs to the stable changelog for already assigned
> > > vulnerabilities?
> > 
> > That's what I did for .5 -> .6.  We can't retroactively update changeset
> > comments, and I'm not sure we have any other candidates in -stable.
> > We'll certainly continue to add them as we have them.
> 
> bk helptool comments

Yeah, I've actually used that, but as Dave mentioned, it's only really
useful while you have the changes locally and haven't pushed them out yet.

thanks,
-chris

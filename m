Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCERtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCERtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVCERqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:46:01 -0500
Received: from 64-85-47-3.ip.van.radiant.net ([64.85.47.3]:12818 "EHLO
	vlinkmail") by vger.kernel.org with ESMTP id S261701AbVCERnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:43:33 -0500
Date: Sat, 5 Mar 2005 09:42:48 -0800
From: Greg KH <greg@kroah.com>
To: Adam Sampson <azz@us-lot.org>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050305174248.GD13104@kroah.com>
References: <20050304222146.GA1686@kroah.com> <y2azmxiifdj.fsf@cartman.at.fivegeeks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y2azmxiifdj.fsf@cartman.at.fivegeeks.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 09:58:00AM +0000, Adam Sampson wrote:
> Greg KH <greg@kroah.com> writes:
> 
> >  - It must fix a problem that causes a build error (but not for things
> >    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
> 
> So a trivial patch that fixed a data corruption issue wouldn't be
> accepted?

Good point, I've now added that.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVI0K0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVI0K0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 06:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVI0K0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 06:26:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:34483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964889AbVI0K0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 06:26:16 -0400
Date: Tue, 27 Sep 2005 03:25:56 -0700
From: Greg KH <greg@kroah.com>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Crazy Idea: Replacing /dev using sysfs over time
Message-ID: <20050927102555.GA7233@kroah.com>
References: <200509261928.20701.shawn.starr@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261928.20701.shawn.starr@rogers.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 07:28:18PM -0400, Shawn Starr wrote:
> I wonder if in the future, we can just eliminate /dev altogether (or map it 
> via sysfs until older apps move away from /dev). It just seems we could 
> represent major,minor in a sysfs node: 

This comes up every few months.  Please read the archives for why this
is not acceptable.

thanks,

greg k-h

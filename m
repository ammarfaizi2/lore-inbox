Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266872AbUGLQXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266872AbUGLQXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266883AbUGLQXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:23:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:16611 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266872AbUGLQXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:23:54 -0400
Date: Mon, 12 Jul 2004 09:22:17 -0700
From: Greg KH <greg@kroah.com>
To: Dale K Dicks <dale_d@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ehci problem with maxtor USB HDD with >=2.6.7
Message-ID: <20040712162217.GA11792@kroah.com>
References: <1089649059.9190.14.camel@linuxbox.home.bluffs.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089649059.9190.14.camel@linuxbox.home.bluffs.ab.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 10:17:39AM -0600, Dale K Dicks wrote:
> 
> I tried this with 2.6.8-rc2 and have the exact same problem.

I did not know that the 2.6.8-rc2 kernel was out yet :)

Anyway, can you try the latest -mm release to see if this is fixed there
or not?

If not, care to file a bug at bugzilla.kernel.org for it so I can assign
it to the proper person?

thanks,

greg k-h

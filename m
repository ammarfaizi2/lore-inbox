Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUGHXwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUGHXwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 19:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGHXwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 19:52:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:20390 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261375AbUGHXwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 19:52:36 -0400
Date: Thu, 8 Jul 2004 16:45:07 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH 1/4] Driver core updates (needed for serio)
Message-ID: <20040708234507.GA23882@kroah.com>
References: <200407072038.27158.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407072038.27158.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 08:38:25PM -0500, Dmitry Torokhov wrote:
> Hi Greg,
> 
> Could you please take a look at the 4 patches below. I would like to finish
> synching up my serio sysfs patches with Vojtech and the rest of my stuff
> depends on these patches, so I would like to know if they are acceptable or
> I need to redo some of these.
> 
> The patches are:

<snip>

All 4 of these patches look fine, and I've applied them to my trees, and
they will show up in the next -mm tree, and in my next push of stuff to
Linus.

thanks,

greg k-h

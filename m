Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVHaGht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVHaGht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 02:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVHaGht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 02:37:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:931 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932397AbVHaGhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 02:37:48 -0400
Date: Tue, 30 Aug 2005 23:34:33 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Kurt Garloff <garloff@suse.de>
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050831063433.GC28960@kroah.com>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825012150.490797000@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 06:20:33PM -0700, Chris Wright wrote:
> Now that capability functions are default, rootplug no longer needs to
> manually add them to its security_ops.
> 
> Cc: Greg Kroah <greg@kroah.com>
> Signed-off-by: Chris Wright <chrisw@osdl.org>

You can add:

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

to this one when you send it on.

thanks,

greg k-h

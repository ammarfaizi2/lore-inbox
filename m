Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVKFUhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVKFUhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 15:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVKFUhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 15:37:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:64211 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751224AbVKFUhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 15:37:09 -0500
Date: Sun, 6 Nov 2005 12:36:36 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051106203636.GC2527@kroah.com>
References: <20051106013752.GA13368@swissdisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106013752.GA13368@swissdisk.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:37:52PM -0800, Ben Collins wrote:
> * A kernel geared toward a real world Linux distribution, supporting
>   drivers and subsystems that end users need. You will find a lot of
>   external drivers in our tree, that for whatever reason, are not included
>   in the upstream kernel. We hope that including these drivers will give
>   users a one-stop kernel (no downloading and compiling external modules),
>   and also provide much needed testing for modules hoping to be included
>   into the mainstream kernel.

Does this include the various closed source drivers that you include in
your distro releases?

thanks,

greg k-h

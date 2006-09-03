Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWICT4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWICT4g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 15:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWICT4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 15:56:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:34257 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932067AbWICT4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 15:56:36 -0400
Date: Sun, 3 Sep 2006 12:56:29 -0700
From: Greg KH <greg@kroah.com>
To: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17.11] xpad: dance pad support
Message-ID: <20060903195629.GA14959@kroah.com>
References: <26b51c320609031236j4884cc9br57ce590c2be074f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b51c320609031236j4884cc9br57ce590c2be074f5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2006 at 03:36:43PM -0400, Adam Buchbinder wrote:
> This patch was originally from Dominic Cerquetti originally written
> for kernel 2.6.11.4, with minor modifications (API changes for USB,
> spelling fixes to the documentation added in the original patch) made
> to apply to the current kernel. This is my first time submitting a
> patch; I've attempted to follow the format laid out in
> SubmittingPatches, but if there's something amiss here (I should have
> listed myself as an author, or I should have moved the documentation
> into another patch), please let me know. Thanks!

Your email client linewrapped the patch:

> diff -uprN -X linux-2.6.17.11/Documentation/dontdiff
> linux-2.6.17.11.orig/Documentation/input/xpad.txt
> linux-2.6.17.11/Documentation/input/xpad.txt
> --- linux-2.6.17.11.orig/Documentation/input/xpad.txt
> 2006-08-31 11:00:48.000000000 -0400
> +++ linux-2.6.17.11/Documentation/input/xpad.txt        2006-08-31
> 16:36:41.000000000 -0400

Care to try it again, and CC: the linux-usb-devel list and the input
subsystem maintainer to get their comments too?

thanks,

greg k-h

-- 
VGER BF report: H 1.77275e-12

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbUCTBHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 20:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUCTBHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 20:07:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:58756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263194AbUCTBHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 20:07:23 -0500
Date: Fri, 19 Mar 2004 17:06:10 -0800
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, claus@momo.math.rwth-aachen.de
Subject: Re: [PATCH 2.6 RFT] add class support to floppy tape driver zftape-init.c
Message-ID: <20040320010610.GB18888@kroah.com>
References: <58110000.1079739485@w-hlinder.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58110000.1079739485@w-hlinder.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 03:38:05PM -0800, Hanna Linder wrote:
> Here is a patch to add class support to zftape-init.c:
> 
> MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
>                    "VFS interface for the Linux floppy tape driver. "
>                    "Support for QIC-113 compatible volume table "
>                    "and builtin compression (lzrw3 algorithm)");
> 
> I have verified it compiles but do not have the hardware to test it.
> If someone who does could test it please do.

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTFBRJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 13:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTFBRJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 13:09:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47572 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264792AbTFBRJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 13:09:19 -0400
Date: Mon, 2 Jun 2003 10:20:16 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] SECURITY_ROOTPLUG must depend on USB
Message-ID: <20030602172016.GB4992@kroah.com>
References: <20030601184436.GD29425@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601184436.GD29425@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 08:44:36PM +0200, Adrian Bunk wrote:
> The following patch lets SECURITY_ROOTPLUG depend on USB (otherwise
> there are link errors since Root Plug Support needs
> usb_bus_list{,_lock}):

Applied, thanks.

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTJXAXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTJXAXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:23:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:2993 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261909AbTJXAXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:23:07 -0400
Date: Thu, 23 Oct 2003 17:07:50 -0700
From: Greg KH <greg@kroah.com>
To: "Kurtis D. Rader" <kdrader@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, pberger@brimson.com,
       borchers@steinerpoint.com
Subject: Re: [PATCH][2.6.0-test7] digi_acceleport.c has bogus "address of" operator
Message-ID: <20031024000750.GE21734@kroah.com>
References: <20031016054821.GA22005@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016054821.GA22005@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 10:48:21PM -0700, Kurtis D. Rader wrote:
> 
> === diff -rup drivers/usb/serial/digi_acceleport.c.orig drivers/usb/serial/digi_acceleport.c
> --- drivers/usb/serial/digi_acceleport.c.orig   2003-10-15 22:03:26.000000000 -0700
> +++ drivers/usb/serial/digi_acceleport.c        2003-10-15 21:10:21.000000000 -0700

This patch does not apply.  It looks like the tabs are converted to
spaces.  Can you send it to me again, so that I can apply it?

thanks,

greg k-h

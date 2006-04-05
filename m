Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWDEUzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWDEUzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWDEUzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:55:25 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:14257
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751013AbWDEUzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:55:24 -0400
Date: Wed, 5 Apr 2006 13:54:41 -0700
From: Greg KH <greg@kroah.com>
To: Denis Sunko <nim4daz@yahoo.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, david@2gen.com
Subject: Re: [PATCH] unusual_devs.h, kernel 2.6.15.6
Message-ID: <20060405205441.GA4922@kroah.com>
References: <20060404141520.7778.qmail@web35506.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404141520.7778.qmail@web35506.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 07:15:20AM -0700, Denis Sunko wrote:
> This patch adds an UNUSUAL_DEV entry which prevents a particular usb
> drive from flooding the console with useless SCSI messages. It is
> patterned after similar ones for other manufacturers. I also took the
> opportunity to correct the order of entries, manufacturer 0x0451 was
> out of order.
> 
> I thank David H?rdeman for help with this one.

This has already been submitted, sorry, someone beat you :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbUDZS5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUDZS5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUDZS5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:57:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:38603 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263338AbUDZS4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:56:39 -0400
Date: Mon, 26 Apr 2004 11:56:12 -0700
From: Greg KH <greg@kroah.com>
To: Marco Cavallini <arm.linux@koansoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with CONFIG_USB_SL811HS
Message-ID: <20040426185612.GB28530@kroah.com>
References: <005c01c42b82$60d82f60$0200a8c0@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005c01c42b82$60d82f60$0200a8c0@arrakis>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 01:33:45PM +0200, Marco Cavallini wrote:
> Hello,
> I am facing to a problem using linux-2.4.25-vrs2 and/or 2.4.26-vrs1 (ARM
> porting).
> I think this problem come from the linux kernel and not from ARM patch.
> Seems that there is a problem building SL811 USB hosts because if I enable
> CONFIG_USB_SL811HS option
> the driver seems to be not build and is not running.

What is the build errors you get when trying to build this driver?

thanks,

greg k-h

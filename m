Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLLV0G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTLLV0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:26:06 -0500
Received: from mail.kroah.org ([65.200.24.183]:40075 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262009AbTLLV0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:26:04 -0500
Date: Fri, 12 Dec 2003 13:15:27 -0800
From: Greg KH <greg@kroah.com>
To: Stian Jordet <liste@jordet.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPP over ttyUSB (visor.o, Treo)
Message-ID: <20031212211527.GC2002@kroah.com>
References: <20031210165540.B26394@fi.muni.cz> <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel> <1071114290.750.18.camel@chevrolet.hybel> <20031211064441.GA2529@kroah.com> <1071152620.753.1.camel@chevrolet.hybel> <1071154385.721.1.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071154385.721.1.camel@chevrolet.hybel>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 03:53:06PM +0100, Stian Jordet wrote:
> 
> I just tried 2.4.24-pre1, and I have the same behaviour, so I guess
> either the ftdi_sio or my mouse is b0rked. Weird, though, since they are
> connected on two different buses, and I have four other usb devices
> connected as well, without problem.

I really think you are exceeding the power limits for this hub, or you
have a flaky device.

thanks,

greg k-h

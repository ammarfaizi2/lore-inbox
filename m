Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbTIIPsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbTIIPsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:48:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:9438 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264194AbTIIPsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:48:21 -0400
Date: Tue, 9 Sep 2003 08:15:21 -0700
From: Greg KH <greg@kroah.com>
To: kinarky <kinarky@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash log with 2.4.22 kernel and usb modem
Message-ID: <20030909151521.GB4499@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <200309090733.02884.kinarky@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309090733.02884.kinarky@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 07:33:02AM +0200, kinarky wrote:
> hello maybe this log describe a 2.4.22 kernel bug, sometimes it make my 
> keyboard leds blink
> it happens when a speedtouch usb modem loose sync, i don't really know what 
> exactly is involved in the kernel

Are you using the userspace or kernel driver for the speedtouch modem?

And can you run that oops through ksymoops and send the output to us?

thanks,

greg k-h

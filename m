Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270092AbTGMENI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbTGMENI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:08 -0400
Received: from mail.kroah.org ([65.200.24.183]:17110 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270092AbTGMENG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:06 -0400
Date: Sat, 12 Jul 2003 21:21:31 -0700
From: Greg KH <greg@kroah.com>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with usb-ohci on 2.4.22-preX
Message-ID: <20030713042131.GE2695@kroah.com>
References: <20030712141431.GA3240@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712141431.GA3240@puettmann.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 04:14:31PM +0200, Ruben Puettmann wrote:
> 
>         hy,
> 
> i try to install linux on my new motherboard EPOX 8RDA3+ 
> with nvidia nforce2 chipset.
> 
> If I try to attached some usb devices ( usb memory stick ) I got this
> errors ( 2.4.22-pre5 pre2..): 

Do any other USB devices work?
Can you boot with/without acpi (the opposite of whatever you just did.)
How about booting with noapic?

thanks,

greg k-h

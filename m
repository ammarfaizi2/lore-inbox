Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWAEXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWAEXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbWAEXq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:46:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:61665 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752303AbWAEXqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:46:40 -0500
Date: Thu, 5 Jan 2006 15:45:28 -0800
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface (rev. 2)
Message-ID: <20060105234528.GA28365@kroah.com>
References: <200601042340.42118.rjw@sisk.pl> <20060105001837.GA1751@elf.ucw.cz> <20060105002619.GA16714@kroah.com> <200601060034.53707.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601060034.53707.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 12:34:52AM +0100, Rafael J. Wysocki wrote:
> > Ok, then I'd recommend using the misc device, dynamic for now, and
> > reserve one when you get a bit closer to merging into mainline.
> 
> Do you mean something like in the appended patch?

Yes, that looks good to me.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTL0UxL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbTL0UxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:53:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:15566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264583AbTL0UxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:53:09 -0500
Date: Sat, 27 Dec 2003 12:51:10 -0800
From: Greg KH <greg@kroah.com>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug and 2.6.0-mm1
Message-ID: <20031227205110.GB21933@kroah.com>
References: <3FEA7192.6020004@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEA7192.6020004@blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 05:11:46AM +0000, Sid Boyce wrote:
> I get failures with hotplug on SuSE 9.0 and found out it is expecting 
> /proc/bus/usb/drivers/ to exist. Modding /etc/hotplug/usb.rc to point to 
> /sys/bus/usb/drivers/ does not fix it.
> Downloaded and built hotplug-2003_08_05.tar.gz (latest I could find), 
> but the file looks just the same and I'm getting "hotplug: can't 
> synthesize events" messages.
> Is there a 2.6.0 hotplug to be had?

The latest version should work just fine on a Red Hat based machine.
Since you are using SuSE, I'd ask them if there are any tweaks that need
to be made for that system.

Good luck,

greg k-h

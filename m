Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLHXmA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTLHXkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:40:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:12702 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261974AbTLHXkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:40:05 -0500
Date: Mon, 8 Dec 2003 15:38:40 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031208233840.GD31370@kroah.com>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <200312081559.04771.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312081559.04771.andrew@walrond.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 03:59:04PM +0000, Andrew Walrond wrote:
> 
> So how good is the device coverage offered by sysfs/udev ? Do they provide a 
> viable/complete MAKEDEV replacement yet?

It works for me on my laptop :)

You might have different devices and need other things.  If so, please
let me know after trying it out.

greg k-h

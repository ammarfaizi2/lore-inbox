Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTDHVZW (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbTDHVZW (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:25:22 -0400
Received: from granite.he.net ([216.218.226.66]:58130 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261885AbTDHVZV (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:25:21 -0400
Date: Tue, 8 Apr 2003 14:37:10 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/i2c/sysfs-interface
Message-ID: <20030408213710.GA6343@kroah.com>
References: <20030408185711.GA5790@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408185711.GA5790@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 08:57:11PM +0200, Pavel Machek wrote:
> Hi!
> 
> First, that file should probably be named sysfs-interface.txt.

Heh, all of the files in that directory do not have a .txt extension.
Neither do lots of other files in Documentation/* :)

> Points to doc/vid, but there's no such file in kernel tree.

Good point, I'll go dig up what that document is, and add it if needed.

thanks,

greg k-h

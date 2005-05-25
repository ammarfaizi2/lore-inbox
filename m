Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVEYCZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVEYCZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVEYCZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:25:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:46499 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261288AbVEYCZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:25:33 -0400
Date: Tue, 24 May 2005 17:23:01 -0700
From: Greg KH <greg@kroah.com>
To: sean <seandarcy2@gmail.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 058 release
Message-ID: <20050525002301.GG15342@kroah.com>
References: <20050520213839.GB16567@kroah.com> <d6o3cn$e4b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6o3cn$e4b$1@sea.gmane.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 03:50:57PM -0400, sean wrote:
> Greg KH wrote:
> >I've released the 058 version of udev.  It can be found at:
> >  	kernel.org/pub/linux/utils/kernel/hotplug/udev-058.tar.gz
> >
> ..............
> >
> >Also, the rules file structure and use is changing again, in more
> >powerful ways.  For more details on this, and if you currently rely on
> >the /etc/dev.d/ feature, please read the RELEASE-NOTES file in the main
> >udev directory.  A online version can be found here:
> >http://www.kernel.org/git/?p=linux/hotplug/udev.git;a=blob;h=9b7fa3133013c4dfc1bc5d759cd198e8aafdef83;hb=5e65ab9a191268fec7cddf6b7d8c0fefd2a6b920;f=RELEASE-NOTES
> >
> 
> This only goes through 0.57 :(.

That's because no new major things happened between 057 (note the lack
of a '.') and 058 except for bugfixes and stuff.

thanks,

greg k-h

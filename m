Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSKMSDP>; Wed, 13 Nov 2002 13:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSKMSDP>; Wed, 13 Nov 2002 13:03:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53266 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262354AbSKMSDO>;
	Wed, 13 Nov 2002 13:03:14 -0500
Date: Wed, 13 Nov 2002 10:04:43 -0800
From: Greg KH <greg@kroah.com>
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
Cc: Oliver Neukum <oliver@neukum.name>, Sean Neakums <sneakums@zork.net>,
       linux-kernel@vger.kernel.org
Subject: Re: hotplug (was devfs)
Message-ID: <20021113180443.GD5446@kroah.com>
References: <20021112093259.3d770f6e.spyro@f2s.com> <20021112094949.GE17478@higherplane.net> <6uadkf9kdt.fsf@zork.zork.net> <200211121351.08328.oliver@neukum.name> <20021113104809.D2386@axis.demon.co.uk> <20021113170204.GC5446@kroah.com> <20021113180606.F7989@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113180606.F7989@axis.demon.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 06:06:06PM +0000, Nick Craig-Wood wrote:
> 
> So I'll be able to say usb bus1/1/4/1 port 3 should be /dev/ttyUSB15
> and it will always be that port?  That would be perfect.

Yes, that is the goal.

thanks,

greg k-h

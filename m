Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbTCSSOA>; Wed, 19 Mar 2003 13:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263140AbTCSSOA>; Wed, 19 Mar 2003 13:14:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2826 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263139AbTCSSOA>;
	Wed, 19 Mar 2003 13:14:00 -0500
Date: Wed, 19 Mar 2003 10:12:45 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.5.65] ehci-hcd, don't use PCI MWI
Message-ID: <20030319181245.GC15212@kroah.com>
References: <3E788B06.4090302@pacbell.net> <20030319153421.GA26181@gtf.org> <3E78927F.4060600@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E78927F.4060600@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 07:53:35AM -0800, David Brownell wrote:
> 
> I'd be happy with that, except on the 2.4 trees where we haven't
> seen such a patch yet.  (So Greg -- please hold off on this
> for 2.5 unless/until it becomes clear Ivan's patch won't happen.)

I'll hold off for both 2.5 and 2.4, as Ivan's patch should go into both
kernels.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283505AbRK3Eam>; Thu, 29 Nov 2001 23:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283504AbRK3Ead>; Thu, 29 Nov 2001 23:30:33 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:31239 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S283488AbRK3EaP>;
	Thu, 29 Nov 2001 23:30:15 -0500
Date: Thu, 29 Nov 2001 20:29:59 -0800
From: Greg KH <greg@kroah.com>
To: Armin Obersteiner <armin@xos.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb slow in >2.4.10
Message-ID: <20011129202959.B8633@kroah.com>
In-Reply-To: <20011130040719.A21515@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130040719.A21515@elch.elche>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 02 Nov 2001 02:24:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 04:07:19AM +0100, Armin Obersteiner wrote:
> hi!
> 
> all my usb devices work, but they are very slow (12 times slower) with kernels
> 2.4.14 and higher. it definetly was ok with 2.4.10.

Which USB Host controller driver are you using?

thanks,

greg k-h

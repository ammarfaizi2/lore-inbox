Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282791AbRK0Eer>; Mon, 26 Nov 2001 23:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282792AbRK0Eeh>; Mon, 26 Nov 2001 23:34:37 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:23826 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282791AbRK0Ee3>;
	Mon, 26 Nov 2001 23:34:29 -0500
Date: Mon, 26 Nov 2001 21:30:57 -0800
From: Greg KH <greg@kroah.com>
To: "John D. Davis" <jddavis@triad.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problems with khub in current 2.4.15-2.4.16 kernels
Message-ID: <20011126213057.A6704@kroah.com>
In-Reply-To: <3C029D3F.E43B4E9C@triad.rr.com> <20011126135142.A4675@kroah.com> <3C031524.50F076CD@triad.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C031524.50F076CD@triad.rr.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 30 Oct 2001 03:14:34 -0800
X-Message-Flag: Message text blocked: Unsuitable for Adults
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 11:23:00PM -0500, John D. Davis wrote:
> Greg,
> The oops only occurs at startup.  here's the oops parsed through ksymoops

Hi,

Then can you boot without the device, then plug it in, and send the
result of /proc/bus/usb/devices?

thanks,

greg k-h

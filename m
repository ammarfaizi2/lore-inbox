Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281470AbRKHFKS>; Thu, 8 Nov 2001 00:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281469AbRKHFKL>; Thu, 8 Nov 2001 00:10:11 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:13316 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S281470AbRKHFKE>;
	Thu, 8 Nov 2001 00:10:04 -0500
Date: Wed, 7 Nov 2001 22:10:05 -0800
From: Greg KH <greg@kroah.com>
To: Pete Toscano <pete.lkml@toscano.org>, linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011107221005.B959@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE870EF.2080508@gutschke.com> <20011106155934.B12661@kroah.com> <20011107225328.A18371@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107225328.A18371@bubba.toscano.org>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 11 Oct 2001 05:01:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 10:53:28PM -0500, Pete Toscano wrote:
> Just in case it matters any, here's the Clie (760C) part of my
> /proc/bus/usb/devices:

Can you try syncing on /dev/ttyUSB0 with coldsync, telling it you have a
m50x and let me know if it works or not?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278584AbRKRJzc>; Sun, 18 Nov 2001 04:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRKRJzV>; Sun, 18 Nov 2001 04:55:21 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:16141 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278584AbRKRJzG>;
	Sun, 18 Nov 2001 04:55:06 -0500
Date: Sun, 18 Nov 2001 02:53:13 -0800
From: Greg KH <greg@kroah.com>
To: Alex Perry <alex.perry@ieee.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 15pre6 omits drivers/usb/serial
Message-ID: <20011118025313.A21950@kroah.com>
In-Reply-To: <E165NAU-0000LQ-00@p2.alex.fastwave.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E165NAU-0000LQ-00@p2.alex.fastwave.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 21 Oct 2001 09:32:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 12:19:10AM -0800, Alex Perry wrote:
> I've just patched 14 to 15pre6 ... the serial driver subdirectory for USB
> doesn't build modules even when requested to do so in the configuration.
> I made the obvious one-line addition to the Makefile for the usb directory,
> and it seems to work for me, but there may be more subtle dependency needs.

Can you send me your .config file?

thanks,

greg k-h

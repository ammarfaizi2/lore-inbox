Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267739AbRGUQpj>; Sat, 21 Jul 2001 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbRGUQp3>; Sat, 21 Jul 2001 12:45:29 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:46354 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267732AbRGUQpR>;
	Sat, 21 Jul 2001 12:45:17 -0400
Date: Sat, 21 Jul 2001 09:45:11 -0700
From: Greg KH <greg@kroah.com>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.6] USB thinks I've got 2 keyboards
Message-ID: <20010721094511.A4830@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0107211739340.28026-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107211739340.28026-100000@jdi.jdimedia.nl>; from i.palsenberg@jdimedia.nl on Sat, Jul 21, 2001 at 05:42:36PM +0200
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 21, 2001 at 05:42:36PM +0200, Igmar Palsenberg wrote:
> 
> A HP pavilion with a USB keyboard and mouse :
> 
> Kernel : 2.4.6

Can you send the result of /proc/bus/usb/devices when this device is
plugged in?

thanks,

greg k-h

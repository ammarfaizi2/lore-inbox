Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCOS03>; Fri, 15 Mar 2002 13:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCOS0L>; Fri, 15 Mar 2002 13:26:11 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:26117 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293060AbSCOS0B>;
	Fri, 15 Mar 2002 13:26:01 -0500
Date: Fri, 15 Mar 2002 10:26:03 -0800
From: Greg KH <greg@kroah.com>
To: Itai Nahshon <nahshon@actcom.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-Storage in 2.4.19-pre
Message-ID: <20020315182603.GC4310@kroah.com>
In-Reply-To: <200203141432.g2EEWL628078@lmail.actcom.co.il> <200203142321.g2ENL1632499@lmail.actcom.co.il> <20020314152617.B3109@kroah.com> <200203150050.g2F0oR615927@lmail.actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203150050.g2F0oR615927@lmail.actcom.co.il>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 15 Feb 2002 16:17:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 02:50:15AM +0200, Itai Nahshon wrote:
> 
> Again, I do not see the disk usind usbview (or in /proc/bus/usb/devices)
> so I believe the problem is more with detection than with initialization.

Sounds like it's a flaky USB device :)

Does this device work on any other machines?

thanks,

greg k-h

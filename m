Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284727AbRLRTAn>; Tue, 18 Dec 2001 14:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284752AbRLRS7I>; Tue, 18 Dec 2001 13:59:08 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:45067 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284604AbRLRS6i>;
	Tue, 18 Dec 2001 13:58:38 -0500
Date: Tue, 18 Dec 2001 10:55:28 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1 API change summary
Message-ID: <20011218105527.C5549@kroah.com>
In-Reply-To: <20011218031427.GA5990@storm.local> <20011218100609.C5273@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011218100609.C5273@kroah.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 20 Nov 2001 16:35:33 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 10:06:09AM -0800, Greg KH wrote:
> > 	include/linux/usb.h:
> > 
> > Yes, there are lots of changes.  I haven't sorted them out yet.
> 
>  - Moved the HID specific defines and functions into include/linux/usb.h
                                                       ^^^^^^^^^^
						       Should have been
						       drivers/usb/hid.h,
						       sorry.

greg k-h

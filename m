Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312362AbSCYTXR>; Mon, 25 Mar 2002 14:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312353AbSCYTXI>; Mon, 25 Mar 2002 14:23:08 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:49934 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312427AbSCYTW6>;
	Mon, 25 Mar 2002 14:22:58 -0500
Date: Mon, 25 Mar 2002 11:22:17 -0800
From: Greg KH <greg@kroah.com>
To: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Microsoft Natural KeyB not recogniced as a HID device
Message-ID: <20020325192216.GD29011@kroah.com>
In-Reply-To: <20020325183011.GA29011@kroah.com> <Pine.LNX.4.30.0203251957590.5375-200000@stud.fbi.fh-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 25 Feb 2002 16:24:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 08:07:21PM +0100, Jan-Marek Glogowski wrote:
> Hi Greg
> 
> [schnipp]
> > Can you try the patches at:
> >       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684196109355
> > and also:
> >       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684207509482
> >
> > And let us know if they help you out?
> [schnapp]
> 
> Applied both patches - the keyboard is detected again, but I still have
> some errors in the lsusb-output (see attachment).

Sounds like a device that is lying about it's strings.  If the device
works, I wouldn't worry about it :)

If it bothers you, take it up with the lsusb author.

thank for testing those patches.

greg k-h

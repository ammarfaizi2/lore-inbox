Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313027AbSDORqP>; Mon, 15 Apr 2002 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSDORqO>; Mon, 15 Apr 2002 13:46:14 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:50956 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313027AbSDORqN>;
	Mon, 15 Apr 2002 13:46:13 -0400
Date: Mon, 15 Apr 2002 09:45:42 -0700
From: Greg KH <greg@kroah.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS: USB disconnect
Message-ID: <20020415164542.GI21707@kroah.com>
In-Reply-To: <3CBA8506.AE090B97@delusion.de> <20020415152310.GH21356@kroah.com> <3CBAFFC2.2FB7ECFE@delusion.de> <20020415155947.GB21707@kroah.com> <3CBB0FE7.73938A47@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 18 Mar 2002 13:44:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 07:37:44PM +0200, Udo A. Steinberg wrote:
> Greg KH wrote:
> 
> > Could you test out 2.5.7 and the HID device support in that version to
> > see if this is a new problem or not?
> 
> Hello,
> 
> 2.5.7 + HID support enabled produces the exact same oops.

Good.  Well, not good, but nice in that it doesn't look like the more
recent changes to the USB tree caused this.  Can you send this oops and
info to the HID maintainer?

thanks,

greg k-h

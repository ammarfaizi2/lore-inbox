Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSIWUDd>; Mon, 23 Sep 2002 16:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261288AbSIWUDH>; Mon, 23 Sep 2002 16:03:07 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:30995 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261356AbSIWUBg>;
	Mon, 23 Sep 2002 16:01:36 -0400
Date: Mon, 23 Sep 2002 13:05:54 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
Message-ID: <20020923200554.GG18769@kroah.com>
References: <20020923192700.GA18707@kroah.com> <E17tZEh-0000qG-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17tZEh-0000qG-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 09:51:15PM +0200, Marek Michalkiewicz wrote:
> 
> In the meantime, may I ask you nicely to add this to 2.4.20
> drivers/usb/storage/unusual_devs.h ?

That's Matt's call, not mine.  And generating a patch for 2.4.20-pre7
and 2.5.38 would help out in getting it accepted :)

thanks,

greg k-h

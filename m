Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSIWTYN>; Mon, 23 Sep 2002 15:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSIWTWv>; Mon, 23 Sep 2002 15:22:51 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:19731 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261344AbSIWTWo>;
	Mon, 23 Sep 2002 15:22:44 -0400
Date: Mon, 23 Sep 2002 12:27:01 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: mdharm-usb@one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: Oops in usb_submit_urb with US_FL_MODE_XLATE (2.4.19 and 2.4.20-pre7)
Message-ID: <20020923192700.GA18707@kroah.com>
References: <20020921225346.GA29052@kroah.com> <E17t9Hb-0006yp-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17t9Hb-0006yp-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 06:08:30PM +0200, Marek Michalkiewicz wrote:
> 
> None of this happens without the US_FL_MODE_XLATE flag...

They don't use that flag. :)

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313803AbSDIHQX>; Tue, 9 Apr 2002 03:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313804AbSDIHQW>; Tue, 9 Apr 2002 03:16:22 -0400
Received: from [195.20.224.249] ([195.20.224.249]:37388 "EHLO samoa.sitewaerts")
	by vger.kernel.org with ESMTP id <S313803AbSDIHQV>;
	Tue, 9 Apr 2002 03:16:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <seeger@sitewaerts.de>
Organization: <sitewaerts> GmbH
To: Greg KH <greg@kroah.com>, Felix Seeger <felix.seeger@gmx.de>
Subject: Re: usb problems (no /dev/usb)
Date: Tue, 9 Apr 2002 09:17:21 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204082106.33705.felix.seeger@gmx.de> <20020408235945.GD10263@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200204090917.21508.seeger@sitewaerts.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. April 2002 01:59 schrieb Greg KH:
> On Mon, Apr 08, 2002 at 09:06:33PM +0200, Felix Seeger wrote:
> > Hi
> >
> > I have tried to install a usb printer but I have no /dev/usb.
> >
> > Usb drivers / usb printer installed (in kernel / module)
> >
> > Do I have to create the folders /dev/usb and the things that are in there
> > ?
>
> If you are not using devfs, yes.
>
> > Why ? ;)
>
> Welcome to Unix :)
>
> thanks,
>
> greg k-h
Ok, it is in development, thats fine ;)
It works now, I've found a mknod command in the newsgroups.

Is there a document for mknod which explaints the numbers at the ond of the 
command. The manpage is not really good.

thanks
have fun
Felix

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSHQTEI>; Sat, 17 Aug 2002 15:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSHQTEI>; Sat, 17 Aug 2002 15:04:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:10251 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318138AbSHQTEH>;
	Sat, 17 Aug 2002 15:04:07 -0400
Date: Sat, 17 Aug 2002 12:03:24 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020817190324.GA9320@kroah.com>
References: <3D5D7E50.4030307@netscape.net> <20020817030604.GB7029@kroah.com> <3D5E595A.7090106@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5E595A.7090106@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 20 Jul 2002 18:01:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 02:10:34PM +0000, Adam Belay wrote:
> 
> 
> greg@kroah.com wrote:
> 
> >
> >Um, your email client mangled the patch, dropping tabs and wrapped
> >lines.
> >
> Thanks for pointing this out.  I'll send it as an attachment this time.
>  My current client has been causing me a lot of trouble, is there one
> you would suggest I use?

I like mutt, but that's just my opinion :)

Hm, in looking at your attachments, they will not apply either.  All the
tabs are gone, something's wrong with your originals.  Did you cut and
paste to generate them?

> >
> >Isn't this info already in the "name" file of a driver?
> >
> 
> I'm probably just confused but I'm not sure what you mean.  This patch 
> does the following, as shown previously:
> 
> example:
> #cd /driverfs/root/pci0/00:00.0
> #cat driver
> agpgart

Ah, got it, nevermind :)

thanks,

greg k-h

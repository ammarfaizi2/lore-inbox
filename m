Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSG1TNG>; Sun, 28 Jul 2002 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSG1TNF>; Sun, 28 Jul 2002 15:13:05 -0400
Received: from zwanebloem.xs4all.nl ([213.84.22.107]:9095 "EHLO
	thuis.zwanebloem.nl") by vger.kernel.org with ESMTP
	id <S317037AbSG1TNF>; Sun, 28 Jul 2002 15:13:05 -0400
Date: Sun, 28 Jul 2002 21:23:41 +0200
To: Greg KH <greg@kroah.com>
Cc: Tommy Faasen <faasen@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020728192341.GA30851@router.zwanebloem.xs4all.nl>
References: <20020711230222.GA5143@kroah.com> <32918.192.168.0.100.1027865196.squirrel@thuis.zwanebloem.nl> <20020728190049.GA5959@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728190049.GA5959@kroah.com>
User-Agent: Mutt/1.4i
From: root <root@thuis.zwanebloem.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 12:00:49PM -0700, Greg KH wrote:
> On Sun, Jul 28, 2002 at 04:06:36PM +0200, Tommy Faasen wrote:
> > Hi,
> > 
> > I just tried to compile 2.5.29, haven't tried dev kernels since 2.5.24 and
> > it seems that although the nvidia kernel module builds ok when I try to
> > start X I get a freeze or a reboot. Any chance it has something to do with
> > this?
> 
> No, I do not.  Without the nvidia kernel module, does everything work
> just fine?
>
Console wise yes, I'll give the xfree86 module a go...

i'll let you know.

Tommy 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

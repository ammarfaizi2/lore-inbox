Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSG1S62>; Sun, 28 Jul 2002 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSG1S62>; Sun, 28 Jul 2002 14:58:28 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:50448 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317306AbSG1S60>;
	Sun, 28 Jul 2002 14:58:26 -0400
Date: Sun, 28 Jul 2002 12:00:49 -0700
From: Greg KH <greg@kroah.com>
To: Tommy Faasen <faasen@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] agpgart splitup and cleanup for 2.5.25
Message-ID: <20020728190049.GA5959@kroah.com>
References: <20020711230222.GA5143@kroah.com> <32918.192.168.0.100.1027865196.squirrel@thuis.zwanebloem.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32918.192.168.0.100.1027865196.squirrel@thuis.zwanebloem.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 30 Jun 2002 17:54:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 04:06:36PM +0200, Tommy Faasen wrote:
> Hi,
> 
> I just tried to compile 2.5.29, haven't tried dev kernels since 2.5.24 and
> it seems that although the nvidia kernel module builds ok when I try to
> start X I get a freeze or a reboot. Any chance it has something to do with
> this?

No, I do not.  Without the nvidia kernel module, does everything work
just fine?

thanks,

greg k-h

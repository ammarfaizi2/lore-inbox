Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSHBRIq>; Fri, 2 Aug 2002 13:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSHBRIq>; Fri, 2 Aug 2002 13:08:46 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:58123 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316258AbSHBRIp>;
	Fri, 2 Aug 2002 13:08:45 -0400
Date: Fri, 2 Aug 2002 10:10:22 -0700
From: Greg KH <greg@kroah.com>
To: Enugala Venkata Ramana <caps_linux@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: installation of latest kernel on compaq notebook
Message-ID: <20020802171022.GA32459@kroah.com>
References: <20020802141213.31759.qmail@webmail30.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020802141213.31759.qmail@webmail30.rediffmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 05 Jul 2002 16:07:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 02:12:13PM -0000, Enugala Venkata Ramana wrote:
> 
> Hi Greg,
> Thanks for response.
> here i am attaching the usb_devices listing.

That device should work just fine with the catc.c driver.  Have you
build that one in your kernel configuration?

thanks,

greg k-h

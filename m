Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbSJJHS3>; Thu, 10 Oct 2002 03:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbSJJHS3>; Thu, 10 Oct 2002 03:18:29 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:62220 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262068AbSJJHS2>;
	Thu, 10 Oct 2002 03:18:28 -0400
Date: Thu, 10 Oct 2002 00:20:06 -0700
From: Greg KH <greg@kroah.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hid-input: fix find_next_zero_bit usage
Message-ID: <20021010072005.GC21465@kroah.com>
References: <20021010045002.GI12775@conectiva.com.br> <20021010091342.A7637@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021010091342.A7637@ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 09:13:42AM +0200, Vojtech Pavlik wrote:
> On Thu, Oct 10, 2002 at 01:50:02AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > Hi Vojtech,
> > 
> > 	Please apply this changeset, comments below, and this has to be
> > applied to both 2.4 and 2.5.
> > 
> > - Arnaldo
> 
> Ok, added it to my repository. Greg, will you please take care of 2.4?

Will do.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275867AbSIUD07>; Fri, 20 Sep 2002 23:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275868AbSIUD07>; Fri, 20 Sep 2002 23:26:59 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:29965 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275867AbSIUD07>;
	Fri, 20 Sep 2002 23:26:59 -0400
Date: Fri, 20 Sep 2002 20:31:38 -0700
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Message-ID: <20020921033137.GA26017@kroah.com>
References: <200207180950.42312.duncan.sands@wanadoo.fr> <E17rwAI-0000vM-00@starship> <20020919164924.GB15956@kroah.com> <200209200656.23956.bhards@bigpond.net.au> <20020919230643.GD18000@kroah.com> <3D8B884A.7030205@pacbell.net> <20020920231112.GC24813@kroah.com> <3D8BDF9A.305@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8BDF9A.305@pacbell.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 07:55:22PM -0700, David Brownell wrote:
> 
> How about a facility to create the character (or block?) special file
> node right there in the driverfs directory?  Optional of course.

No, Linus has stated that this is not ok to do.  See the lkml archives
for the whole discussion about this.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJDEsL>; Fri, 4 Oct 2002 00:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSJDEsL>; Fri, 4 Oct 2002 00:48:11 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:4110 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261486AbSJDEsK>;
	Fri, 4 Oct 2002 00:48:10 -0400
Date: Thu, 3 Oct 2002 21:50:51 -0700
From: Greg KH <greg@kroah.com>
To: John Tyner <jtyner@cs.ucr.edu>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       kraxel@bytesex.org
Subject: Re: Vicam/3com homeconnect usb camera driver
Message-ID: <20021004045051.GB3556@kroah.com>
References: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0210032047510.15999-400000@hill.cs.ucr.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 08:59:30PM -0700, John Tyner wrote:
> 
> The code is for for 2.4.19, and I'll port it forward to 2.5 if it
> seems like it would be useful.
> 
> Apologies:
> 	1. The files are not a patch but should build outside of the tree.

If you send me a patch for 2.5, I'd be glad to add it to the tree.
Right now, I'm not accepting USB drivers that don't show up in 2.5
first.

Other than that, the code looks nice.  Did you look at how the usb video
drivers do their memory management in 2.4.20-pre like I mentioned
before?

thanks,

greg k-h

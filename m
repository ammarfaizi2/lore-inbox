Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSLWWg5>; Mon, 23 Dec 2002 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbSLWWg5>; Mon, 23 Dec 2002 17:36:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:50190 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266997AbSLWWg5>;
	Mon, 23 Dec 2002 17:36:57 -0500
Date: Mon, 23 Dec 2002 14:41:29 -0800
From: Greg KH <greg@kroah.com>
To: mdew <mdew@orcon.net.nz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] [TRIVIAL] USB Joypad quirk
Message-ID: <20021223224129.GA31917@kroah.com>
References: <1040556042.9822.17.camel@nirvana> <20021223191232.GA31060@kroah.com> <1040677522.28347.2.camel@nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040677522.28347.2.camel@nirvana>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 10:04:30AM +1300, mdew wrote:
> On Tue, 2002-12-24 at 08:12, Greg KH wrote:
> > On Mon, Dec 23, 2002 at 12:20:30AM +1300, mdew wrote:
> > > Orginally from Vojtech Pavlik (16th June 2002 via email), to fix my
> > > 'broken' USB joypad, Fully tested in both 2.4.x and 2.5.52 (and
> > > 2.5.52-bk).
> > 
> > Applied to my 2.5 tree, thanks.
> > 
> > Can you also send a 2.4 version, as this one does not work for that
> > tree?
> 
> sure

Sorry, but this does not apply to 2.4.21-pre2, can you try again?

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSKBXVV>; Sat, 2 Nov 2002 18:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSKBXVV>; Sat, 2 Nov 2002 18:21:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48904 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261499AbSKBXVS>;
	Sat, 2 Nov 2002 18:21:18 -0500
Date: Sat, 2 Nov 2002 15:24:28 -0800
From: Greg KH <greg@kroah.com>
To: Jochen Friedrich <jochen@scram.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] USB Kernel bug in 2.5.45
Message-ID: <20021102232428.GB24425@kroah.com>
References: <20021102204419.GB22607@kroah.com> <Pine.LNX.4.44.0211030010060.18761-100000@gfrw1044.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211030010060.18761-100000@gfrw1044.bocc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:10:43AM +0100, Jochen Friedrich wrote:
> Hi Greg,
> 
> > If you disable devfs does it work ok?
> 
> Yes, it does...

Great, thanks for trying.  I don't see any more problems here :)

thanks,

greg k-h

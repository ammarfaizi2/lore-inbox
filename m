Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319222AbSIDQTR>; Wed, 4 Sep 2002 12:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIDQTR>; Wed, 4 Sep 2002 12:19:17 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:42254 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319222AbSIDQTP>;
	Wed, 4 Sep 2002 12:19:15 -0400
Date: Wed, 4 Sep 2002 09:21:54 -0700
From: Greg KH <greg@kroah.com>
To: Peter <cogweb@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-ac4 build problem
Message-ID: <20020904162154.GM6198@kroah.com>
References: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209032237460.25475-100000@greenie.frogspace.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 10:50:59PM -0700, Peter wrote:
> 
> Is there a fix for this compilation problem? I've tried gcc 2.95.3, 3.0, 
> and 3.1 and get the same:
> 
> drivers/usb/usbdrv.o: In function `hidinput_hid_event':

What driver is this?  It isn't in the main 2.4.x tree.

thanks,

greg k-h

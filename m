Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbTCaSYv>; Mon, 31 Mar 2003 13:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCaSYv>; Mon, 31 Mar 2003 13:24:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30482 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261759AbTCaSYu>;
	Mon, 31 Mar 2003 13:24:50 -0500
Date: Mon, 31 Mar 2003 10:34:24 -0800
From: Greg KH <greg@kroah.com>
To: Dick Streefland <dicks@altium.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.66] Oops in bttv driver
Message-ID: <20030331183424.GC18688@kroah.com>
References: <1071.3e85dd92.989cd@altium.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071.3e85dd92.989cd@altium.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29, 2003 at 05:53:22PM -0000, Dick Streefland wrote:
> I tried to upgrade from 2.4.20 to 2.5.66, but got a kernel panic during
> the initialization of the bttv driver. I captured the oops via a serial
> console:

I've posted a patch for this oops to the list last week, take a look in
tha archive for it.  It's also already in the -bk tree if you want to
apply the latest snapshot patches.

Sorry about this,

greg k-h

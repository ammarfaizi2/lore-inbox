Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTAFVdr>; Mon, 6 Jan 2003 16:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTAFVdr>; Mon, 6 Jan 2003 16:33:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62981 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267204AbTAFVdq>;
	Mon, 6 Jan 2003 16:33:46 -0500
Date: Mon, 6 Jan 2003 13:42:20 -0800
From: Greg KH <greg@kroah.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: status on the new driver model?
Message-ID: <20030106214220.GA22207@kroah.com>
References: <1041888351.12319.15.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041888351.12319.15.camel@tiger>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 04:25:51PM -0500, Louis Garcia wrote:
> What is the status of the new driver model?

It's currently working, mount sysfs and take a look.

> Are the driver being ported over in a timely fashion?

Yes.

> Is this process going to be complete before the code freeze/2.6?

Depends, are you willing to help out?  :)

> I've heard the PCI bus and drivers are not yet converted to strut
> devices?

Not true at all, have you even looked at the current 2.5 code?

> Oh, is the old LDM or what ever is was being riped out or left for
> compatibility?

What "old LDM"?

Again, you can find all the answers to your questions by actually
looking at the code.

thanks,

greg k-h

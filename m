Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268243AbTAMTcU>; Mon, 13 Jan 2003 14:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268269AbTAMTcU>; Mon, 13 Jan 2003 14:32:20 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:8710 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268243AbTAMTcS>;
	Mon, 13 Jan 2003 14:32:18 -0500
Date: Mon, 13 Jan 2003 11:41:09 -0800
From: Greg KH <greg@kroah.com>
To: Nico Schottelius <schottelius@wdt.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.56] (partial known) bugs/compile errors
Message-ID: <20030113194109.GD8394@kroah.com>
References: <20030113090200.GA1096@schottelius.org> <20030113190105.GA8394@kroah.com> <20030113193401.GA330@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113193401.GA330@schottelius.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 08:34:01PM +0100, Nico Schottelius wrote:
> Greg KH [Mon, Jan 13, 2003 at 11:01:06AM -0800]:
> > On Mon, Jan 13, 2003 at 10:02:00AM +0100, Nico Schottelius wrote:
> > > WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown symbol usb_bus_list_lock
> > > WARNING: /lib/modules/2.5.56/kernel/security/root_plug.ko needs unknown symbol usb_bus_list
> > 
> > Do you have CONFIG_USB selected in your .config?
> 
> yes, but all usb things are modularized

And what is your CONFIG_SECURITY_* options?

thanks,

greg k-h

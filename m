Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292761AbSCDWnb>; Mon, 4 Mar 2002 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292952AbSCDWnQ>; Mon, 4 Mar 2002 17:43:16 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:9738 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292761AbSCDWnC>;
	Mon, 4 Mar 2002 17:43:02 -0500
Date: Mon, 4 Mar 2002 14:35:31 -0800
From: Greg KH <greg@kroah.com>
To: Sebastian =?iso-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.5-dj2] USB keyboard strangeness and ALSA error
Message-ID: <20020304223530.GA5280@kroah.com>
In-Reply-To: <20020304211949.26f188ac.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020304211949.26f188ac.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Feb 2002 20:31:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 09:19:49PM +0100, Sebastian Dröge wrote:
> Hi,
> I've following problems with 2.5.5-dj2:
> If I try to enable numlock I get this message: hid-core.c: control queue full
> and the numlock LED doesn't shine but numlock is enabled
> This is on a USB keyboard (Cherry xyz... the one with included USB hub)
> While booting I get this message: hid-core.c: ctrl urb status -32 received

Can you please try 2.5.6-pre2 and let us know if you still have the USB
problem with that kernel?

thanks,

greg k-h

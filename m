Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVFNGjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFNGjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVFNGjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:39:04 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:31018 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261247AbVFNGjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:39:01 -0400
Date: Mon, 13 Jun 2005 23:38:51 -0700
From: Greg KH <gregkh@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-hotplug-devel@lists.sourceforge.net,
       Vojtech Pavlik <vojtech@suse.cz>, Kay Sievers <kay.sievers@vrfy.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Input sysbsystema and hotplug
Message-ID: <20050614063851.GA19620@suse.de>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613221657.GB15381@suse.de> <9e473391050613232170f57ea3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050613232170f57ea3@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 02:21:53AM -0400, Jon Smirl wrote:
> On 6/13/05, Greg KH <gregkh@suse.de> wrote:
> > > where inputX are class devices, mouse and event are subclasses of input
> > > class and mouseX and eventX are again class devices.
> > 
> > Yes, lots of people want class devices to have children.  Unfortunatly
> > they don't provide patches with their requests :)
> 
> I did, but you didn't like it.

Heh, yes, sorry, you did.

Hm, I don't even remember why I didn't like it anymore, last I remember,
I think you got the parent reference counting correct, right?  Care to
dig out the patch and send it again?

thanks,

greg k-h

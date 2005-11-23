Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVKWAhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVKWAhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVKWAhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:37:24 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:9865 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1030276AbVKWAhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:37:23 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Christmas list for the kernel
Date: Wed, 23 Nov 2005 00:37:27 +0000
User-Agent: KMail/1.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <1132702505.20233.88.camel@localhost.localdomain> <9e4733910511221558o4eb493cdhfef81e632c5306e7@mail.gmail.com>
In-Reply-To: <9e4733910511221558o4eb493cdhfef81e632c5306e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511230037.27997.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 23:58, Jon Smirl wrote:
> On 11/22/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Maw, 2005-11-22 at 16:13 -0500, Jon Smirl wrote:
> > > All of the legacy stuff - VGA, Vesafb, PS2, serial, parallel,
> >
> > PCI Parallel and serial hotplug
> > PS2 hotplugs if you've got hotpluggable PS2 - I've even used this
> > Most Joysticks hotplug
> > Gameports mostly hotplug
> > VESAfb is by definition not hotplug capable
> > VGA hotplug we don't do but you can load the module.
>
> The devices that plug into the ports hotplug, but the existence of the
> ports themselves does not autodetect/hotplug at boot time.

I think this is referred to as "cold plug".

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.

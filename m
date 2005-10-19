Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVJSNpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVJSNpz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 09:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVJSNpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 09:45:55 -0400
Received: from scooby.digital-creationsonline.com ([71.138.45.129]:15275 "EHLO
	scooby.digital-creationsonline.com") by vger.kernel.org with ESMTP
	id S1750777AbVJSNpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 09:45:54 -0400
From: "James E. Jennison" <james.jennison@digital-creationsonline.com>
Organization: Digital Creations Online
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: ImExPS/2 status
Date: Wed, 19 Oct 2005 06:45:49 -0700
User-Agent: KMail/1.8.2
References: <200510181711.19618.james.jennison@digital-creationsonline.com> <200510190030.54715.dtor_core@ameritech.net>
In-Reply-To: <200510190030.54715.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510190645.49426.james.jennison@digital-creationsonline.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 22:30, you wrote:
<Cut to save space and not be so long>
...
...
...
> > I have included the results from what dmesg displayed when I connected
> > the mouse to the computer, as well as some of the output from
> > /var/log/messages:
> >
> > input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
> >
> > Oct 18 06:47:25 scooby gpm[18741]: Started gpm successfully. Entered
> > daemon mode.
> > Oct 18 06:48:46 scooby kernel: psmouse.c: bad data from KBC - timeout
> > Oct 18 06:48:47 scooby hal.hotplug[22794]: DEVPATH is not set
> > Oct 18 06:48:47 scooby hal.hotplug[22836]: DEVPATH is not set
> > Oct 18 06:48:47 scooby kernel: input: PS/2 Generic Mouse on
> > isa0060/serio1
>
> So you start without a mouse plugged in and still it detects a mouse?

No,  in both instances, the mouse was already plugged in.

> > Oct 18 06:52:54 scooby hal.hotplug[2047]: DEVPATH is not set
> > Oct 18 06:52:55 scooby hal.hotplug[2133]: DEVPATH is not set
> > Oct 18 06:52:55 scooby kernel: input: ImExPS/2 Generic Explorer Mouse on
> > isa0060/serio1
>
> And here you plug the mouse, right?
>
> > Oct 18 06:54:28 scooby hal.hotplug[5846]: DEVPATH is not set
> > Oct 18 06:54:28 scooby hal.hotplug[5884]: DEVPATH is not set
> > Oct 18 06:54:29 scooby kernel: input: PS/2 Generic Mouse on
> > isa0060/serio1

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275909AbSIUMqI>; Sat, 21 Sep 2002 08:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275910AbSIUMqI>; Sat, 21 Sep 2002 08:46:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46333 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S275909AbSIUMqI>; Sat, 21 Sep 2002 08:46:08 -0400
Date: Sat, 21 Sep 2002 08:51:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200209211251.g8LCpFt23725@devserv.devel.redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: my review of the Device Driver Hardening Design Spec
In-Reply-To: <mailman.1032587460.6299.linux-kernel2news@redhat.com>
References: <mailman.1032587460.6299.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	- actually, what do any of these CONFIG_ options do, and why
> 	  would someone not want the CONFIG_DRIVER_ROBUST to be always
> 	  enabled?

Probably performance blows when it is enabled.

> In summary, I think that a lot of people have spent a lot of time in
> creating this document, and the surrounding code that matches this
> document.  I really wish that a tiny bit of that effort had gone into
> contacting the Linux kernel development community, and asking to work
> with them on a project like this.  Due to that not happening, and by
> looking at the resultant spec and code, I'm really afraid the majority
> of that time and effort will have been wasted.

Eek. They never mentioned any code before now. In fact they
explicitly said they weren't going to code before the spec
was ready.

-- Pete

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVE3DYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVE3DYW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 23:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVE3DYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 23:24:22 -0400
Received: from coat.coat.com ([164.153.10.15]:5023 "EHLO coat.coat.com")
	by vger.kernel.org with ESMTP id S261508AbVE3DYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 23:24:18 -0400
Date: Sun, 29 May 2005 23:22:27 -0400 (EDT)
From: "Michael Sterrett -Mr. Bones.-" <msterret@coat.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: Lee Revell <rlrevell@joe-job.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>, gregkh@gentoo.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to find if BIOS has already enabled the device
In-Reply-To: <200505282017.08204.kernel-stuff@comcast.net>
Message-ID: <Pine.LNX.4.61.0505292317220.5375@rutrow.coat.com>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com>
 <200505281301.09911.kernel-stuff@comcast.net> <1117325172.5423.102.camel@mindpipe>
 <200505282017.08204.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463791516-2093748871-1117423347=:5375"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463791516-2093748871-1117423347=:5375
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 28 May 2005, Parag Warudkar wrote:

> On Saturday 28 May 2005 20:06, Lee Revell wrote:
>> devfs is not maintained and is listed as deprecated.  You'd be better
>> off using udev.
>
> Yep, that's on my list of things to do - I tried once to switch to udev but
> it's not the  "just works" type - atleast on Gentoo!

Wow, I definitely disagree, considering that the udev maintainer has
commit privileges for Gentoo.

Try http://www.gentoo.org/doc/en/udev-guide.xml for help.

Michael Sterrett
   -Mr. Bones.-
mr_bones_@gentoo.org
---1463791516-2093748871-1117423347=:5375--

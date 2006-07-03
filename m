Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWGCWO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWGCWO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWGCWO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:14:57 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:23963 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750988AbWGCWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:14:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dDQ5tuNODhW72Pfz/gDZeOYg74DlQmln9ssR17c36sRiCUUKL+s2o8p5Qu7p4WxmqqqHazdrHjDis50aNiLw+pq3sgW5S61HaeoTmYnjuOy09WO7EmIykYcXI3XIJ8/GsK/TETkUgokk9MMWiZ0NEMwENsb6RNterbDDgfQSysM=
Message-ID: <6bffcb0e0607031514r6e14c68am5964f07265e0caeb@mail.gmail.com>
Date: Tue, 4 Jul 2006 00:14:55 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: romit.linux@gmail.com
Subject: Re: CONFIG for udev to work?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607040332.48506.romit.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607040332.48506.romit.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/07/06, Romit <romit.linux@gmail.com> wrote:
> Hi,
>
>     I sent a query to linux-hotplug-devel a few days back but did not get any
> reply, so I am posting it here.
> I upgraded from 2.6.13-15  to 2.6.17.1 and I can't see any UEVENT message
> generation. I am running udevmonitor and it is just blocking on receiving
> UEVENT from the kernel even after I insert a usb keyboard/ usb storage / usb
> bluetooth dongle.
> I am running SUSE LINUX 10.0.
> I am sure that I am missing some CONFIG iitem. All I want to know is what
> arethem essential items that I need to enable for udev to work.Kindly let me
> know what CONFIG item I am missing.

Documentation/Changes

"udev            071                     # udevinfo -V"

>
> Thanks in advance
> -Romit
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

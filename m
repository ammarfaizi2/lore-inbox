Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDXMRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDXMRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDXMR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:17:29 -0400
Received: from hermes.drzeus.cx ([193.12.253.7]:55242 "EHLO mail.drzeus.cx")
	by vger.kernel.org with ESMTP id S1750730AbWDXMR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:17:29 -0400
Message-ID: <444CC1E2.5000101@drzeus.cx>
Date: Mon, 24 Apr 2006 14:17:38 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>
CC: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: SD Card not mounting
References: <8bf247760604240215j12af040dk4e695dbe03d89a83@mail.gmail.com>
In-Reply-To: <8bf247760604240215j12af040dk4e695dbe03d89a83@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Hi,
>    When i try to mount an generic SD Card on my hardware. i get the error:
> 
> mount /dev/mmcblk0 /mnt/mmc -t vfat
> mount: Mounting /dev/mmcblk0 on /mnt/mmc failed: Device or resource busy
> 

You should cc the relevant maintainers when sending questions/bug
reports. Otherwise it will just get lost in the sheer volume of mail.

Since I don't recognise what driver you're using I'm adding Russell King
(the MMC maintainer) as cc.

Rgds
Pierre


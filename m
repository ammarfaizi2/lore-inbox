Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313338AbSC2DBy>; Thu, 28 Mar 2002 22:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313339AbSC2DBf>; Thu, 28 Mar 2002 22:01:35 -0500
Received: from BOLZANO.MIT.EDU ([18.87.0.43]:41933 "EHLO bolzano.mit.edu")
	by vger.kernel.org with ESMTP id <S313338AbSC2DBc>;
	Thu, 28 Mar 2002 22:01:32 -0500
Date: Thu, 28 Mar 2002 22:01:30 -0500
From: Matthew Walburn <matt@math.mit.edu>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: mkinitrd w/ 2.4.18
Message-ID: <20020328220130.A2627@math.mit.edu>
Mail-Followup-To: Matthew Walburn <matt@math.mit.edu>,
	linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <mailman.1017365942.20950.linux-kernel2news@redhat.com> <200203290248.g2T2mDA29032@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would appreciate if you hit enter about every 70 keystrokes.

Sorry about that didnt realize it wasn't wrapping.

> Also, describing a symptom rather than vague "i'm having problems"
> may help.

Specifically, i get the error message:
"all of your loopback devices are in use"

I have the follow kernel options enabled, using Redhat's kernel
config as a guide:

CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y

Thanks for the help.

-Matt

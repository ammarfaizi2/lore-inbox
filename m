Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRKXSqa>; Sat, 24 Nov 2001 13:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279303AbRKXSqK>; Sat, 24 Nov 2001 13:46:10 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:969 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S279064AbRKXSqJ>; Sat, 24 Nov 2001 13:46:09 -0500
Date: Sat, 24 Nov 2001 13:46:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200111241846.fAOIk8B01067@devserv.devel.redhat.com>
To: john@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: Etiquette of getting a driver into the kernel
In-Reply-To: <mailman.1006511470.4667.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1006511470.4667.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...] Some kind soul on the net mailed me a newer
> version, which does work a lot more reliably. The email address given for
> the original author (in the source) doesn't seem to answer requests like
> "is there a newer version of this driver", or "Is this driver GPL'd ?".
> 
>  Basically, I've a patch for it against 2.4.15, and I'm wondering how I
> should go about getting it into the kernel, so others can debug it for me :)

You must resolve the licensing issue first. Once you are
done, send it to linux-usb-devel@lists.sourceforge.net.
The USB subsystem has an active maintainer currently.

-- Pete

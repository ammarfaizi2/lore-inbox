Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSFZO5r>; Wed, 26 Jun 2002 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSFZO5r>; Wed, 26 Jun 2002 10:57:47 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16389 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316616AbSFZO5q>;
	Wed, 26 Jun 2002 10:57:46 -0400
Date: Wed, 26 Jun 2002 07:57:41 -0700
From: Greg KH <greg@kroah.com>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net, mwilck@freenet.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
Message-ID: <20020626145741.GD4611@kroah.com>
References: <E17My7H-0007Ew-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17My7H-0007Ew-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 29 May 2002 13:38:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 11:44:51PM +0200, Marek Michalkiewicz wrote:
> Hi,
> 
> please consider the small patch below (for 2.4.19-rc1), adding support
> for the Sagatek DCS-CF (aka Datafab KECF-USB - 07c4:a400) USB-CompactFlash
> apdapter.  Tested a little by copying files back and forth - transfer
> speed is about 600 KB/s, and it hasn't crashed on me yet.  I understand
> it is a bit late before 2.4.19, but the device does not work at all
> without the patch, and the patch does not change anything for other
> vendor:device IDs, so there should be no risk of breaking things...

Heh, send this to me again after 2.4.19-final is out, and I'll
reconsider it :)

thanks,

greg k-h

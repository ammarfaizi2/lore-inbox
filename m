Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUEBQs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUEBQs0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 12:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUEBQs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 12:48:26 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:61347 "EHLO
	smtp-out3.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263162AbUEBQsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 12:48:25 -0400
From: Edward Macfarlane Smith <snowfire@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: mmc/sd drivers
Date: Sun, 2 May 2004 17:49:46 +0100
User-Agent: KMail/1.6.1
Cc: Pavel Machek <pavel@suse.cz>, tj <999alfred@comcast.net>
References: <408D3DC0.8080700@comcast.net> <20040427141453.GQ2595@openzaurus.ucw.cz>
In-Reply-To: <20040427141453.GQ2595@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405021749.46941.snowfire@blueyonder.co.uk>
X-OriginalArrivalTime: 02 May 2004 16:48:26.0806 (UTC) FILETIME=[4A356560:01C43065]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 April 2004 15:14, Pavel Machek wrote:
> Hi!
>
> > Where can the latest mmc drivers in the kernel source be located? I
> > am not talking about mass-storage usb or pcmcia drivers. I downloaded
> > 2.2.26 and there is no drivers/mmc directory. Where can the mmc
> > drivers be located from their original distribution point?
>
> 2.2 is old.
>
> MMC is supported for example on sharp zaurus, look
> there for sources. SD requires binary-only module. Avoid it.

Thats not completely true. Last weekend I was using a 512Mb SD card on my iPAQ 
5550 with the 2.4.19 hh36.9 kernel from Handhelds.org. It was rather slow 
access (playing mp3s directly off the sd card had problems with pauses), but 
did work. I haven't actually got around to building a kernel for an ARM 
machine yet, but if you need the source I suggest you look round 
handhelds.org.
Regards,
Edward

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262952AbTC0Ooy>; Thu, 27 Mar 2003 09:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262991AbTC0Ooy>; Thu, 27 Mar 2003 09:44:54 -0500
Received: from 015.atlasinternet.net ([212.9.93.15]:50640 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id <S262952AbTC0Oox>; Thu, 27 Mar 2003 09:44:53 -0500
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre6 (about PPC32)
Date: Thu, 27 Mar 2003 15:55:55 +0100
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303271555.55944.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Support Radeon 9K variants in radeonfb.
> 
> Well...
>  
> I have a bunch of quite important radeonfb updates (including all
> these new chipset support stuffs) that are waiting for Ani (the
> maintainer) to send them to Marcelo.

I don't know how they are related to you benX version available via rsync, 
but in ben9 the X server goes to a loop right after resuming on a iBook 
G3-500 with 7500-M. I was reported it happens also on G3-800 with radeon.

Also, dmasound stopped working in the G3-500, it gives a "No space left in 
device" error while trying to write to /dev/dsp. My last working version 
is 2.4.20-rc1-ben0. I think I already reported to you, but just in case.

Regards,


-- 
  ricardo galli       GPG id C8114D34

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTBBHAE>; Sun, 2 Feb 2003 02:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbTBBHAE>; Sun, 2 Feb 2003 02:00:04 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:30340 "EHLO
	yeti.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265126AbTBBHAD>; Sun, 2 Feb 2003 02:00:03 -0500
Date: Sun, 2 Feb 2003 18:09:16 +1100
From: CaT <cat@zip.com.au>
To: leonard <leonard@internetdown.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MenuConfig 2.4.20 does n0t show all drivers (ACPI, SONYPI, UDF_RW) + MAINTAINERS
Message-ID: <20030202070916.GH743@zip.com.au>
References: <20030202005819.605e17f2.leonard@internetdown.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202005819.605e17f2.leonard@internetdown.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 02, 2003 at 12:58:19AM -0500, leonard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello great Gurus ;)
> 
> Eventough the drivers are provided in the source tree,
> some options are missing (?!) in the 'make menuconfig'
> of the linux 2.4.20 kernel.
> 
> Thoses I found missing are the drivers for : ACPI, SONYPI, UDF_RW.

Just a stab in the dark but, have you tried turning on the experimental
features option? (from memory it's in the first menu).

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to         kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)


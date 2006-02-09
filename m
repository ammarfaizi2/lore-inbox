Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030625AbWBIKAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030625AbWBIKAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWBIKAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:00:11 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49891 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1030625AbWBIKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:00:09 -0500
Date: Thu, 9 Feb 2006 11:00:08 +0100
From: Martin Mares <mj@ucw.cz>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jim@why.dont.jablowme.net, peter.read@gmail.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <mj+md-20060209.095744.7127.atrey@ucw.cz>
References: <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208162828.GA17534@voodoo> <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo> <43EB0DEB.nail52A1LVGUO@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB0DEB.nail52A1LVGUO@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Please explain me:
> 
> -	how to use /dev/hd* in order to scan an image from a scanner
> -	how to use /dev/hd* in order to talk to a CPU device
> -	how to use /dev/hd* in order to talk to a tape device
> -	how to use /dev/hd* in order to talk to a printer
> -	how to use /dev/hd* in order to talk to a jukebox
> -	how to use /dev/hd* in order to talk to a graphical device

Nobody speaks about using /dev/hd* for all that, just about that
there always will be a /dev/something corresponding to the device.

Also, as you have mentioned /dev/hd*, it seems that you consider
all these devices connected over ATAPI. Again an exercise in mythical
zoology as in the ATAPI tape example.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
For every complex problem, there's a solution that is simple, neat and wrong.

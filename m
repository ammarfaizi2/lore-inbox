Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWBQPhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWBQPhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWBQPhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:37:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4577 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751479AbWBQPhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:37:20 -0500
Date: Fri, 17 Feb 2006 16:36:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olivier Galibert <galibert@pobox.com>
cc: Matthias Andree <matthias.andree@gmx.de>, Nix <nix@esperi.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060214184142.GA51709@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0602171635080.27452@yvahk01.tjqt.qr>
References: <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
 <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix>
 <20060214092207.GA32405@merlin.emma.line.org> <Pine.LNX.4.61.0602141908360.32490@yvahk01.tjqt.qr>
 <20060214184142.GA51709@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My IDE one is neither nowhere in /sys/class. (Maybe I did not try looking 
>> hard enough, though.)
>
>Why care, official policy is that you should do device discovery
>through udevinfo and not touch sysfs.
>
Hm, it's in /sys/block/hdb.

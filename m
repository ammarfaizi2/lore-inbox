Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422727AbWBNSJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWBNSJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422750AbWBNSJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:09:27 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40620 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422727AbWBNSJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:09:26 -0500
Date: Tue, 14 Feb 2006 19:09:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060214092207.GA32405@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0602141908360.32490@yvahk01.tjqt.qr>
References: <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix>
 <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com>
 <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix>
 <20060214092207.GA32405@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> (I doubt libscg would ever be interested in the stuff in most of the
>> other directories: things like /dev/mem are not SCSI devices and never
>> will be, and /sys/class/scsi_device contains *everything* Linux
>> considers a SCSI device, no matter what transport it is on, SATA and
>> all. However, I don't know if it handles IDE devices that you can SG_IO
>> to because I don't have any such here. Anyone know?)
>
>My ATAPI DVD and CD writers are not listed in /sys/class/scsi_device.
>
My IDE one is neither nowhere in /sys/class. (Maybe I did not try looking 
hard enough, though.)



Jan Engelhardt
-- 

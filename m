Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWBMQnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWBMQnw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBMQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:43:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:898 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932151AbWBMQnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:43:51 -0500
Date: Mon, 13 Feb 2006 17:43:41 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: davidsen@tmr.com, chris@gnome-de.org, nix@esperi.org.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F088AB.nailKUSB18RM0@burner>
Message-ID: <Pine.LNX.4.61.0602131742460.24297@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de>
 <43D7AF56.nailDFJ882IWI@  <43ED005F.5060804@tmr.com>
 <1139615496.10395.36.camel@localhost.localdomain> <43F088AB.nailKUSB18RM0@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well, "any user" just opens his Windows Explorer and takes a look at the
>> icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
>> interesting to see professional programmers often argue that a
>
>This is not true: a drive letter mapping does not need to exist on MS-WIN
>in order to be able to access it via ASPI or SPTI.
>
I have to support this view. Linux filesystems do not show up in Windows 
Explorer (because there's obviously an fs driver lacking), but there's 
always a way to damage your Linux from within Windows.



Jan Engelhardt
-- 

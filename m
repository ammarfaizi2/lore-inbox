Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030493AbWBNILu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030493AbWBNILu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWBNILu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:11:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33694 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1030493AbWBNILt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:11:49 -0500
Date: Tue, 14 Feb 2006 09:11:34 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Luke-Jr <luke@dashjr.org>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, davidsen@tmr.com,
       chris@gnome-de.org, nix@esperi.org.uk, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <200602131727.26945.luke@dashjr.org>
Message-ID: <Pine.LNX.4.61.0602140909190.7198@yvahk01.tjqt.qr>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <43F088AB.nailKUSB18RM0@burner> <Pine.LNX.4.61.0602131742460.24297@yvahk01.tjqt.qr>
 <200602131727.26945.luke@dashjr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Well, "any user" just opens his Windows Explorer and takes a look at the
>> >> icon of his drive D:\\ to see whether it's a CD-ROM or DVD. It is
>> >> interesting to see professional programmers often argue that a
>> >
>> >This is not true: a drive letter mapping does not need to exist on MS-WIN
>> >in order to be able to access it via ASPI or SPTI.
>>
>> I have to support this view. Linux filesystems do not show up in Windows
>> Explorer (because there's obviously an fs driver lacking), but there's
>> always a way to damage your Linux from within Windows.
>
>Really? My Windows-using friend has all his Linux partitions fully visible and 
>usable in Windows Explorer...
>
Might depend! On DOS and Win98, there is no indication in either 
DOS or Explorer that there is a second harddisk (got an xfs on it) at all. 
Only partition entries with Win* type get a drive letter (which does not 
imply reading is also possible).
Might be different on your Windows.



Jan Engelhardt
-- 

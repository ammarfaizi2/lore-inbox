Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUHGKy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUHGKy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUHGKy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 06:54:28 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:20425 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261426AbUHGKy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 06:54:27 -0400
Date: Sat, 7 Aug 2004 12:53:50 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408071053.i77Aromi006941@burner.fokus.fraunhofer.de>
To: mj@ucw.cz, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Martin Mares <mj@ucw.cz>

>> I see always the same answers from Linux people who don't know anyrthing than
>> their belly button :-(
>> 
>> Chek Solaris to see that your statements are wrong.

>Well, so could you please enlighten the Linux people and say in a couple
>of words how it could be done?

1)	Fetch the Solaris install CD images from:
	http://wwws.sun.com/software/solaris/solaris-express/get.html

	Solaris is free for personal use and free for being used to 
	develop OSS.

2)	"unzip" the CD images

3)	use cdrecord to write the CDs

4)	Start installation with CD#1

	......

5)	Take a look at /etc/path_to_inst and call "man path_to_inst"

The used method even works nicely for USB devices.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily

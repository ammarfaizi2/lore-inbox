Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTKNLvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 06:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbTKNLvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 06:51:10 -0500
Received: from no-dns-yet.demon.co.uk ([62.49.87.163]:49803 "EHLO
	mailgate.scotcomms.co.uk") by vger.kernel.org with ESMTP
	id S262373AbTKNLvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 06:51:06 -0500
Message-ID: <09A92EA4A9D2D51182170004AC96FE7A1216BB@mercury.scotcomms>
From: Patrick Beard <patrick@scotcomms.co.uk>
To: "'Andries Brouwer'" <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 11:51:57 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
X-Scanner: exiscan *1AKcTZ-0003FN-00*arCY7T2ZL4A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My fstab entry is;
> > /dev/sda    /mnt/smedia    vfat    rw,user,noauto    0,0
> 
> I would guess that you have to mount /dev/sda1 or perhaps /dev/sda4.
> Isn't that what you do under 2.4?
> 
> Andries

Hi Andries,

Yes, with 2.4 I used sda1. When I first compiled 2.6 I used sda1 but I got
the 'wrong fs..' error. This was a clean install of debian so I didn't have
my original fstab. I checked the web and noticed people using sda. so I
tried that - same error. In trying to get this to work I've used sda and
sda1 at different times both gave the same errors.

Thanks for your reply,

--
Patrick 


Whilst we have taken every effort to ensure that all attachments 
are virus free, use is at the recipients own risk.

_________________ANTI_VIRUS PROTECTION___________________ 

This message has been checked for all known viruses by Norman Anti-Virus. 
For further information visit http://www.norman.com 



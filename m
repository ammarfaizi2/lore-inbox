Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264961AbSJWM4q>; Wed, 23 Oct 2002 08:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSJWM4q>; Wed, 23 Oct 2002 08:56:46 -0400
Received: from 24-216-100-96.charter.com ([24.216.100.96]:53699 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S264961AbSJWM4p>;
	Wed, 23 Oct 2002 08:56:45 -0400
Date: Wed, 23 Oct 2002 09:02:51 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: One for the Security Guru's
Message-ID: <20021023130251.GF25422@rdlg.net>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Once there was a company durring the dot.com boom.  This company had 
some outside consultants come in and tell them how to do a number of
things.  Many of the things were laughed off but some stuck.  2 things
in particular are giving me nightmares now that I'm at this company.
They have survived the bust and I think will actually stand a very good
chance to be very important in the near future so I want to see them
stay sane, stable and secure.

  The consultants aparantly told the company admins that kernel modules
were a massive security hole and extremely easy targets for root kits.
As a result every machine has a 100% monolithic kernel, some of them
ranging to 1.9Meg in filesize.  This of course provides some other
sticky points such as how to do a kernel boot image.

  I'd like it from the guru's on exactly how bad a hole this really is
and if there is a method in the kernel that will prevent such exploits.
For example, if I disable CONFIG_MODVERSIONS is the kernel less likely
to accept a module we didn't build?  Are there plans to implement some
form of finger printing on modules down the road?

Thanks for your imput guys,
  Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                
                               
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.
FYI:
 perl -e 'print $i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'


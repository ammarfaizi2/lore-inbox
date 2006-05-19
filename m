Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWESRXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWESRXH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 13:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWESRXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 13:23:07 -0400
Received: from mail.visionpro.com ([63.91.95.13]:6444 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751402AbWESRXG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 13:23:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Invalid module format?
Date: Fri, 19 May 2006 10:23:01 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3264@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Invalid module format?
Thread-Index: AcZ7aAqZzfBCJ2gRTSWVj3WR/WszWQAAKZhw
From: "Brian D. McGrew" <brian@visionpro.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use the same Makefile for both 2.6.15 and 2.6.16

-->
/usr/src/redhat/BUILD/kernel-2.16.16/linux-2.16.16/drivers/mvp/Makefile

obj-m += ibb.o
obj-m += ibb3d.o
obj-m += mvp_rtc.o




:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!

-----Original Message-----
From: Randy.Dunlap [mailto:rdunlap@xenotime.net] 
Sent: Friday, May 19, 2006 10:19 AM
To: Brian D. McGrew
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format?

On Fri, 19 May 2006 10:11:48 -0700 Brian D. McGrew wrote:

> My drivers are inline in this mail.  I'm still having this problem
with
> the 2.6.16 kernel as where I'm not having it with the 2.6.15 kernel --
> and it's the same source code, compiled the same way.
> 
> Also, I'm still having difficulties getting this driver to work
> correctly so any help would be great!
> 
> -->
>
/usr/src/redhat/BUILD/kernel-2.6.16.16/linux-2.6.16.16/drivers/mvp/mvp_r
> tc.c

what Makefile do you use?

---
~Randy

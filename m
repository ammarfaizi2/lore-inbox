Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWH1OLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWH1OLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWH1OLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:11:07 -0400
Received: from mail.visionpro.com ([63.91.95.13]:24201 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1750793AbWH1OLE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:11:04 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: mounting Floppy and USB - 2.6.16.16
Date: Mon, 28 Aug 2006 07:11:02 -0700
Message-ID: <14CFC56C96D8554AA0B8969DB825FEA0012B3B16@chicken.machinevisionproducts.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: mounting Floppy and USB - 2.6.16.16
Thread-Index: AcbIyz3/8/Zk9RlsSdi+8Rus17LfSAB4DqyA
From: "Brian D. McGrew" <brian@visionpro.com>
To: "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>,
       "For users of Fedora Core releases" <fedora-list@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Friday, August 25, 2006 9:51 PM
To: Brian D. McGrew
Cc: linux-kernel@vger.kernel.org; For users of Fedora Core releases
Subject: Re: mounting Floppy and USB - 2.6.16.16

On Fri, Aug 25, 2006 at 02:55:36PM -0700, Brian D. McGrew wrote:
> Hey Guys:
> 
> With 2.4.20 and 2.6.9 I had all this automated so everything just
> happened automatically.  It's not working with 2.6.16.16 now.  What am
I
> missing or what did I forget?

What version of udev and hal are you using?

What specific errors are you having?

thanks,

greg k-h
-----
15_ yum list | grep hal
hal.i386                                 0.4.7-1.FC3
installed       
hal-cups-utils.i386                      0.5.2-8
installed       
hal-devel.i386                           0.4.7-1.FC3
installed       
hal-gnome.i386                           0.4.7-1.FC3
installed       
hal-debuginfo.i386                       0.4.7-1.FC3
updates-released
16_

16_ yum list | grep udev
udev.i386                                039-10.FC3.8
installed       
udev-debuginfo.i386                      039-10.FC3.8
updates-released

It 'looks' like I have the latest?  I'm not getting any "errors".  But
with RH7.3/2.4.20 and FC3/2.6.9 inserting a CD or USB Flash drive
mounted automatically.  I upgraded to 2.6.16.16 on the previously
working FC3 machines and now it doesn't --- so I'm sure I missing
something in the kernel configuration and just don't know what it
is!?!?!

Thanks!

:b!

Brian D. McGrew { brian@visionpro.com || brian@doubledimension.com }
--
> This is a test.  This is only a test!
  Had this been an actual emergency, you would have been
  told to cancel this test and seek professional assistance!


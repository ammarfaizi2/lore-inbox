Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbTF2Oy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbTF2Oy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:54:29 -0400
Received: from [65.248.106.250] ([65.248.106.250]:34234 "EHLO brianandsara.net")
	by vger.kernel.org with ESMTP id S265676AbTF2Oy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:54:28 -0400
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Date: Sun, 29 Jun 2003 10:08:30 -0500
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <1056867876.11843.1.camel@sonja> <Pine.LNX.4.56.0306290619560.24286@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.56.0306290619560.24286@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306291008.30571.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't really care which is faster, so please don't cc me in any replieds to 
this thread, I 'm just telling my experience.

I've tried OpenGFS on an external firewire hard drive, and I got 13 MB/s(it 
was read, but it shows that the bus can at least handle that much) on a 
WD310100 (which is a pretty old 10GB udma33 hard drive). That would probably 
be even better with ext2 or some fs other than OpenGFS.

--Brian Jackson

On Sunday 29 June 2003 05:24 am, Mr. James W. Laferriere wrote:
> 	Hello Daniel ,
>
> On Sun, 29 Jun 2003, Daniel Egger wrote:
> > Am Sam, 2003-06-28 um 22.31 schrieb Alan Cox:
> > > I'm testing the USB2 disk idea at the moment. Big problem is
> > > performance - 5Mbytes/second isnt the best backup rate in the world.
> >
> > Which are 300Mbytes/minute, still faster than many tapes.
>
>             ^^^^^^^^^^^^^^^^
> 	5MB/Sec is faster than MOST tapes drivs ?  Or ???
> 	If you are talking older scsi-2 or 1 drives yes .
> 	But on a properly tuned system any of the newer tape drives s/b
> 	able beat that hands down .
>
> > I've also made the experience that IEEE1394 (aka Firewire/iLink) is
> > always faster than USB2.
>
> 	I'd like to see a raising hands that have this functional at
> 	anywhere near line (60% is close enough) rate ?
> 		Tia ,  JimL

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net


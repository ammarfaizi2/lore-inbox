Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTDKStO (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 14:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbTDKStO (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 14:49:14 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:27113 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261464AbTDKStN (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 14:49:13 -0400
From: Oliver Neukum <oliver@neukum.org>
Reply-To: oliver@neukum.name
To: John Bradford <john@grabjohn.com>, greg@kroah.com (Greg KH)
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Fri, 11 Apr 2003 21:00:54 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       message-bus-list@redhat.com, dsteklof@us.ibm.com (Daniel Stekloff)
References: <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <200304112030.25344.oliver@neukum.org>
In-Reply-To: <200304112030.25344.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304112100.54360.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 11. April 2003 20:30 schrieb Oliver Neukum:
> Am Freitag, 11. April 2003 19:46 schrieb John Bradford:
> > > > - Performance. What happens if you plug in 4000 disks at once?
> > >
> > > You crash your power supply :)
> >
> > [Puzzle]
> >
> > Say the power supply had five 5.25" drive power connecters, how many 1
> > into 3 power cable splitters would you need to connect all 4000 disks?
>
> About 2000.
> 5 + 15 + 45 + 135 + 405 +1215 and a few more.

Or to be more exact. To 1215 connectors you can connect 3645
drives. 4000-3645 = 355 drives need 178 further splitters.

	Regards
		Oliver


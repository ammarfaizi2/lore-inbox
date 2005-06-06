Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVFFUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVFFUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVFFUXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:23:08 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:56326 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261682AbVFFUWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:22:35 -0400
X-IronPort-AV: i="3.93,174,1115010000"; 
   d="scan'208"; a="269717082:sNHT23181708"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Mon, 6 Jun 2005 15:22:45 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3AE@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVq1CtopPdkQeuOSgiEg5f87HA1hQAAK0Lw
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 06 Jun 2005 20:22:46.0604 (UTC) FILETIME=[807AD8C0:01C56AD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I was assuming that this would wait forever, and is why I pointed
you
> > in
> > > this direction.  Sorry about the confusion here.
> > >
> > I guess the earlier method of request_firmware would work out as is
with
> > the only disadvantage of the user having to depend on hotplug
mechanism
> > and echoing firmware name.
> > Let me know if that is acceptable till we find a solution to wait
for
> > ever without using hotplug stuff.
> 
> Why not fix the firmware_class.c code now?  :)
> 
I can sure submit a patch later but for now please accept it in the
tree. 
Due to scheduling issues it may not be possible for me to fix this now.

Thanks,
Abhay

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTAVQKn>; Wed, 22 Jan 2003 11:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbTAVQKn>; Wed, 22 Jan 2003 11:10:43 -0500
Received: from [65.193.106.66] ([65.193.106.66]:31775 "EHLO
	xchangeserver2.storigen.com") by vger.kernel.org with ESMTP
	id <S261732AbTAVQKl> convert rfc822-to-8bit; Wed, 22 Jan 2003 11:10:41 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ok, which wise guy did this?
Date: Wed, 22 Jan 2003 11:19:45 -0500
Message-ID: <7BFCE5F1EF28D64198522688F5449D5AC6336E@xchangeserver2.storigen.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ok, which wise guy did this?
Thread-Index: AcLCDDLSXi3v4rgfTpGS9YrgNUfL8wAJaQAg
From: "Larry Sendlosky" <Larry.Sendlosky@storigen.com>
To: "jamal" <hadi@cyberus.ca>, <netdev@oss.sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Didn't the same thing happen in the 2.2 -> 2.4
transition? I believe it was for all PCI devices.
And I thought there was a boot arg something
like pci=reverse.  Does it still exist?

larry

-----Original Message-----
From: jamal [mailto:hadi@cyberus.ca]
Sent: Wednesday, January 22, 2003 6:48 AM
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: ok, which wise guy did this?



I just booted my spanking new P4 HT PC last night using 2.5.58
and to my dissapointment the enumeration of the ethx devices is
reversed. I have 5 ethernet ports on this; eth0-4 on 2.4.x are now listed
as eth4-0. This is rude.
I immediately pointed a finger at monsieur J Garzik (thinking ethernet,
PCI enumeration hmm) but he has denied any responsibility ;-> ;-> He
thinks it may be the sysfs people.
Can anyone give justification for this? Regardless of justification
can we have some form of backward compatibility flag?

cheers,
jamal




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267046AbUBEW5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267050AbUBEW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 17:57:33 -0500
Received: from hermes.py.intel.com ([146.152.216.3]:38535 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S267046AbUBEW51 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 17:57:27 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Thu, 5 Feb 2004 14:55:54 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3685@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsOfj7zxKqp2KjRaWjy6FHVxAM6wAACvow
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, <ftillier@infiniconsys.com>,
       <cfriesen@nortelnetworks.com>, <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>, <hozer@hozed.org>, <woody@jf.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 22:55:57.0027 (UTC) FILETIME=[3739DB30:01C3EC3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think what started the discussion was that
if anyone wanted to look at the code and start to comment 
before we have a 2.6 patch ready they can download it from bitkeeper at

http://infiniband.bkbits.net/iba

or if you want, I could post a tar ball of the latest BK change set on
sourceforge,
or you can wait till we make all the changes to the makefiles, etc, to
allow it to 
easily integrate into the 2.6 build environment.

Any preference ?

-----Original Message-----
From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
Sent: Thursday, February 05, 2004 2:40 PM
To: Christoph Hellwig
Cc: Hefty, Sean; ftillier@infiniconsys.com; cfriesen@nortelnetworks.com;
greg@kroah.com; linux-kernel@vger.kernel.org; hozer@hozed.org;
woody@jf.intel.com; Magro, Bill; woody@jf.intel.com;
infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
theLinux kernel


On Thu, 5 Feb 2004 22:40:43 +0000 Christoph Hellwig <hch@infradead.org>
wrote:

| On Thu, Feb 05, 2004 at 02:26:46PM -0800, Hefty, Sean wrote:
| > Personally, I'm amazed that professional developers have to discuss 
| > or defend modular, portable code.
| > 
| > Once the code has been submitted, then specific implementation 
| > problems can be dealt with.
| 
| *plonk*


Christoph, he didn't say merged.  Let them submit it for review... and
then comment on it.

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUBXR4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 12:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUBXR4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 12:56:38 -0500
Received: from fmr05.intel.com ([134.134.136.6]:5572 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262337AbUBXR4c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 12:56:32 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Date: Tue, 24 Feb 2004 09:55:25 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C36C4@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in theLinux kernel
Thread-Index: AcPsPqdZVWAIV0mtRn+g9y/ezMiUFwOv/K4A
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Hefty, Sean" <sean.hefty@intel.com>
Cc: "Tillier, Fabian" <ftillier@infiniconsys.com>,
       "Chris Friesen" <cfriesen@nortelnetworks.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <hozer@hozed.org>, "Woodruff, Robert J" <woody@jf.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>, <woody@jf.intel.com>,
       <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 24 Feb 2004 17:55:27.0014 (UTC) FILETIME=[62597460:01C3FAFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 03:20:46PM -0800, Greg KH Wrote,

>Great, when is this going to happen?  I think I'm not going to respond
anymore
>to this thread until I see some actual code.

Ok, we now have the InfiniBand Access Layer (IBAL) integrated and
building in 
the 2.6.3 environment and have a patch that we can provide. We have not
yet 
fixed the issues that you have raised so far (such as the abstraction
layer), 
but wanted to submit the code so that we can get additional 
feedback from you and all of the community, as you requested. 

Would you like me to submit the patch directly to linux-kernel email
list ? 

I have also posted it to the InfiniBand sourceforge website at:

http://sourceforge.net/projects/infiniband

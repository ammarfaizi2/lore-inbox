Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbUBXT3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 14:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbUBXT3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 14:29:36 -0500
Received: from fmr05.intel.com ([134.134.136.6]:63137 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262401AbUBXT3f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 14:29:35 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: PATCH - InfiniBand Access Layer (IBAL)
Date: Tue, 24 Feb 2004 11:29:04 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C36C7@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcP7DHdWfbgaUnMKRqOT2/tN2A87Kg==
From: "Woodruff, Robert J" <woody@co.intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Greg KH" <greg@kroah.com>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       <marcelo.tosatti@cyclades.com>, <torvalds@osdl.org>
X-OriginalArrivalTime: 24 Feb 2004 19:29:06.0284 (UTC) FILETIME=[77B202C0:01C3FB0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since it is rather big,
I have posted a patch for the InfiniBand Access Layer (IBAL) 
for the linux-2.6.3 kernel on sourceforge in the file releases
area. 
http://sourceforge.net/projects/infiniband

We have already received some comments from Greg and others(such as 
not liking the Component library (Complib) abstraction layer)
and we are starting to make those changes. Greg suggested that
we submit the code to the larger Linux community for review, 
so here it is. 

Please let us know what other changes might be needed so that it is
acceptable for inclusion into the 2.6 base. 

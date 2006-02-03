Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWBCS2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWBCS2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBCS2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:28:22 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:41175 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751350AbWBCS2W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:28:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 13:28:21 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9963@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo6m0O5irPL7EzRC+j98OcNoMLTAABNYww
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>,
       "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Bill Davidsen" <davidsen@tmr.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> That's why I still think there are no bad sectors at all (at 
> least not because of this). Is there any way to actually find out?

Run the Verify (or Verify with Fix) Task on the controller, the report
will indicate the reasons for inconsistencies.

-- Mark

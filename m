Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVBKQlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVBKQlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBKQlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 11:41:39 -0500
Received: from magic.adaptec.com ([216.52.22.17]:4307 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262271AbVBKQlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 11:41:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: aacraid fails under kernel 2.6
Date: Fri, 11 Feb 2005 11:41:29 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458BC57CD7@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: aacraid fails under kernel 2.6
Thread-Index: AcUQUt2t6znBHJSkRraC1imCXJMFrgABX5iQ
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Jonathan Knight" <jonathan@cs.keele.ac.uk>,
       "Mark Haverkamp" <markh@osdl.org>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then turn off both read and write cache on the card ...

You should contact Dell Technical support as there are many reasons for
the adapter to fail ranging from bad power supply, cables, drives etc.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Jonathan Knight [mailto:jonathan@cs.keele.ac.uk] 
Sent: Friday, February 11, 2005 11:01 AM
To: Mark Haverkamp
Cc: Jonathan Knight; linux-kernel; Salyzyn, Mark
Subject: Re: aacraid fails under kernel 2.6

> A number of people have seen problems like this going from 2.4 to 2.6.
> Mark Salyzyn from Adaptec has suggested in those cases to make sure
that
> the board firmware is up to date.  I've copied Mark on this mail.


We think we're on the latest everything.  The BIOS is A07 and the
firmware
on the controller is 2.8.0 build 6092



-- 
  ______    jonathan@cs.keele.ac.uk    Jonathan Knight,
    /                                  Department of Computer Science
   / _   __ Telephone: +44 1782 583437 University of Keele, Keele,
(_/ (_) / / Fax      : +44 1782 713082 Staffordshire.  ST5 5BG.  U.K.

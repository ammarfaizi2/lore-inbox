Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVAYHQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVAYHQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVAYHQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:16:56 -0500
Received: from fmr16.intel.com ([192.55.52.70]:34522 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261846AbVAYHQy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:16:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: possible CPU bug and request for Intel contacts
Date: Mon, 24 Jan 2005 23:15:47 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB7506494302E61B9A@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: possible CPU bug and request for Intel contacts
Thread-Index: AcUAbBviDuuQBRS0QMOLHK+jeFFqvgCQTsLg
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>, "Kirill Korotaev" <dev@sw.ru>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Andrey Savochkin" <saw@sawoct.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jan 2005 07:15:52.0509 (UTC) FILETIME=[B428AED0:01C502AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <mailto:pavel@ucw.cz> wrote on Saturday, January 22, 2005
2:03 AM:

> Hi!
> 
>> Here are the details about CPU bug I mentioned in my previous post.
>> Though it turned out later that it happens on P-III systems only I
>> still hope it can be of interest.
> 
> What about Pentium-M? They are based on P-III and are certainly *very*
> interesting.
> 								Pavel

This issue does not happen on Pentium-M.  This issue happens only on
some PIII steppings.  Information about the affected stepping is
provided in the spec update link.

http://www.intel.com/design/pentiumiii/specupdt/24445351.pdf

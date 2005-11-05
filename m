Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbVKEB5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVKEB5d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 20:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVKEB5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 20:57:33 -0500
Received: from fmr24.intel.com ([143.183.121.16]:19350 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750784AbVKEB5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 20:57:32 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH]: Clean up of __alloc_pages
Date: Fri, 4 Nov 2005 17:57:18 -0800
Message-ID: <01EF044AAEE12F4BAAD955CB75064943051354E2@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH]: Clean up of __alloc_pages
Thread-Index: AcXhm6qKqgBkNxCjRsmq4ksW1y3t3AAEGXtw
From: "Seth, Rohit" <rohit.seth@intel.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <akpm@osdl.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Nov 2005 01:57:19.0905 (UTC) FILETIME=[4179C110:01C5E1AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Nick Piggin [mailto:nickpiggin@yahoo.com.au] 


>I really don't want a change of behaviour going in with this,
>especially not one which I would want to revert anyway. But
>don't get hung up with it - when you post your latest patch
>I will make a patch for the changes I would like to see for it
>and synch things up.


Well, those reverts are what I'm trying to avoid ;-)

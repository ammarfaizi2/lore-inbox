Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTIHGVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 02:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTIHGVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 02:21:24 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:46819 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262049AbTIHGVW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 02:21:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Scaling noise
Date: Mon, 8 Sep 2003 02:21:10 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FD35@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Scaling noise
Thread-Index: AcN1hZmDu0HokYbZSzGT3ltYnNcREQAQbPPA
From: "Brown, Len" <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Larry McVoy" <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Giuliano Pochini" <pochini@shiny.it>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Sep 2003 06:21:12.0391 (UTC) FILETIME=[6672A570:01C375D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 5) NUMA machines are slow.  There is not a single NUMA machine in the
>    top 10 of the top500 supercomputers list.  Likely this has more to
>    do with system sizes supported by the manufacture than inherent
>    process inferiority, but it makes a difference.

Hardware that is good at running linpack (all you gotta run to get onto
http://www.top500.org/ )isn't necessarily hardware that is any good at,
say, http://www.tpc.org/

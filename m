Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTJTKqa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 06:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTJTKqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 06:46:30 -0400
Received: from [193.41.178.98] ([193.41.178.98]:4045 "HELO secemail")
	by vger.kernel.org with SMTP id S262522AbTJTKq3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 06:46:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re:[2.6.0-test3,6,7] IDE 'enhanced mode' problems
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
Date: Mon, 20 Oct 2003 12:46:44 +0200
Message-ID: <9E8BE1B970A998468D92381A112AA3EA0140DE@srvrm001.roma.seceti.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re:[2.6.0-test3,6,7] IDE 'enhanced mode' problems
Thread-Index: AcOW93QV8pwDyj6nSK+ggg6wlwR9jg==
From: "Catani, Antonio" <Antonio.Catani@seceti.it>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Oct 2003 10:46:45.0109 (UTC) FILETIME=[746FFA50:01C396F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, i have the similar problem with 2.6.0-test7-bk9 asua p4c800 deluxe
without any sata disk,if apply libata patch durig boot I see intel ich5
right detected, but if enable enanched mode in ide interface, the system
say me disabling irq18 and see many trouble with ide interface, without
data corruption, but the system is unusable.

If disable enanched mode, the system it's ok.
Another ints, from 2.6.0-test6-mm4 with libata to the last snapshot
2.6.0-test7-mk9 I'v notice a downgrade of ide performance not so much
but there is.

I hope this help you 

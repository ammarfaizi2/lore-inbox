Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTJHNVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTJHNVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:21:50 -0400
Received: from [193.41.178.98] ([193.41.178.98]:52392 "HELO secemail")
	by vger.kernel.org with SMTP id S261508AbTJHNVt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:21:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: some info about on asus p4c800-deluxe
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
Date: Wed, 8 Oct 2003 15:22:01 +0200
Message-ID: <9E8BE1B970A998468D92381A112AA3EA3F34@srvrm001.roma.seceti.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: some info about on asus p4c800-deluxe
Thread-Index: AcONnyiRkqp/4MclTemcMag8geffcg==
From: "Catani, Antonio" <Antonio.Catani@seceti.it>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Oct 2003 13:22:02.0109 (UTC) FILETIME=[28D85AD0:01C38D9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi people, excuse me if could be OT.
I have a asus p4c800 and with a gentoo installed, the gentoo use kernel
2.4.22 but this kernel, is extremely slow on my mobo, I suspect intel
875 chipset is the cause of slow.

I try to use 2.6.0-test6 kernel, but it's impossible go at the end of
the boot cause some trap some dump and other things like that.

I jhave successfully applied patch-2.6.0-test6-bk9, with thi parch I
never see any trap or dump, except if use pnp feature, without this the
kernel start, but 
Show me a cannot found device "hda2" that is my root device, I have
checked my grub conf and is true, someone know some issue about not know
hda2 with this kernel?

Many thanks, and excuse me if my message is OT if you could, point me to
some docs about howto investigate 

Many thanks

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKHKZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKHKZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 05:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVKHKZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 05:25:52 -0500
Received: from [202.125.80.34] ([202.125.80.34]:5150 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S932400AbVKHKZv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 05:25:51 -0500
Content-class: urn:content-classes:message
Subject: Elaboration on module compilation process ?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 8 Nov 2005 15:52:08 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B13B3A5@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which version of 2.6.11 is most stable
Thread-Index: AcXjkZhOrF7iOkE1S/Sc9lZvQ6nMswACUzwgAAFt9JAAKuqNcA==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear All,

I have an issue with compiling a simple kernel module over the 2.4.20-8 kernel on my X86 machine(RH Rel 9).
I guess I touched some of the header files in the kernel source dir i.e. /usr/src/linux-2.4.20-8. 
So I am getting the Compile time error.

Where as it works fine on the other machine next to me running the same RH 9.
So, I tried to simply fix this by replacing the entire Linux kernel source directory on my system with the one nxt to me.

YES, I could get the module compiled smoothly now. But I am not able to load the module into the running kernel.
I end up getting the "kernel-module version mismatch" error.


I guess if I modify the kernel version in a particular file in the kernel sources I would be able to fix it.
Can some help me suggesting where does the module compilation process pick the kernel version from the source directories?

Thanks & regards,
Mukund Jampala



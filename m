Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVGGGdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVGGGdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVGGGdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:33:40 -0400
Received: from [202.125.86.130] ([202.125.86.130]:21723 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261174AbVGGGdj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:33:39 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: Fedora core 3 Version magic error..
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 7 Jul 2005 12:12:12 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811610712@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fedora core 3 Version magic error..
Thread-Index: AcWCu2FJ7PfIhzmiTKW7U16G068McA==
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,
 
I have a problem loading the rpm build locally on Fedora core 3, linux kernel 2.6.10.
 
After building the rpm file from the available sources on the Linux kernel 2.6.10 which was D/W from kernel.org and build, I am unable to load it.
 
It results in the following errors:-
tifm: version magic '2.6.10 686 REGPARM gcc-3.3' should be '2.6.10 REGPARM gcc-3.4'
 
Probably, It's only failing due to gcc version mismatch. 
When I look at the cc in /bin it points to gcc.3.4.
 
Can some one suggest me a solution for this issue?
 
Thanks a million for the helps.
 
Regards,
Mukund Jampala
 
 


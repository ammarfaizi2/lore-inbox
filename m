Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268093AbUHFFYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268093AbUHFFYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 01:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUHFFYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 01:24:47 -0400
Received: from [202.125.86.130] ([202.125.86.130]:55717 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S268093AbUHFFYq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 01:24:46 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: error inserting module - invalid argument
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Fri, 6 Aug 2004 10:55:51 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811067EE8@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: error inserting module - invalid argument
Thread-Index: AcR7cu0mmnROcfqQS9S27Nzzynm+NAAAAVjAAABphHA=
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have a problem regarding inserting a module.
 
I have the driver rpm with me in which I insert the module & accomplish other requirements of my driver.

When I say 

rpm -ivh tifm-1.3-1.i586.rpm
 
This is working fine on my system i.e on Suse 9.1 ( 2.6.5-7.71 kernel).
 
But, the client has a problem even when he works on a system with the same configuration 
i.e. Suse 9.1 ( 2.6.5-7.71 kernel)
 
He got the following error message :-
 
Error inserting tifm  (/lib/modules/2.6.5-7.71-default/kernel/drivers/block/tifm.ko): Invalid argument.
 
His system hangs after then.
What might be the reason behind it.
 
Regards,
Seenu.
 
 

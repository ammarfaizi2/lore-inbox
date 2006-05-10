Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWEJMG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWEJMG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWEJMG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:06:28 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:46866 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S964932AbWEJMG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:06:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: 2.6.16-rt17, hang with skge network driver
Date: Wed, 10 May 2006 08:06:24 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7011B268D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rt17, hang with skge network driver
Thread-Index: AcZzA4I2Ir27LTWpTouUSA0SNQwiGgBJgDug
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "Fernando Lopez-Lezcano" <nando@ccrma.Stanford.EDU>,
       "lkml" <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
X-OriginalArrivalTime: 10 May 2006 12:06:25.0041 (UTC) FILETIME=[28E87810:01C6742A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Ingo, I've seen a few hangs with 2.6.16-rt17 - my feeling 
> was that they had to do with high network load - and this 
> time something was left behind after the reboot (I have to 
> set up a serial console, it is not happening very 
> frequently). Most probably this does not say much but here it 
> goes anyway:

I've switch from sk98lin to skge this morning using 2.6.17-rc3-git17
since the sk98lin driver simply drops my connection after a little while
and also has a lot of problem enbling the connection with my linksys
(although it`s linux also).  

Suprisingly my PC frozed about an hour after the driver switch?  Maybie
it is not a problem with the real-time patch of Ingo since I'm not using
it?

- vin

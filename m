Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULFRHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULFRHw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbULFRHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:07:35 -0500
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:27601 "EHLO
	exil1.paradigmgeo.net") by vger.kernel.org with ESMTP
	id S261566AbULFRHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:07:30 -0500
Content-class: urn:content-classes:message
Subject: RE: Correctly determine amount of "free memory"
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 6 Dec 2004 19:04:30 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <06EF4EE36118C94BB3331391E2CDAAD9CD06BA@exil1.paradigmgeo.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Correctly determine amount of "free memory"
Thread-Index: AcTbrh3vVl/eAb/jSNCDuatAZ9xofgABietw
From: "Gregory Giguashvili" <Gregoryg@ParadigmGeo.com>
To: "bert hubert" <ahu@ds9a.nl>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think a guy called 'Ben' from google went over this a couple of
years ago, the discussion might 
> still be relevant. His email address contained 'google.com' and he
posted on lkml.

Is http://www.cs.helsinki.fi/linux/linux-kernel/2001-43/0661.html what
you mean? If so, it is about mlock problems in 2.4.9 kernels.
Unfortunatelly, they don't discuss available memory issue even though
it's mentioned a couple of times.

Thanks 
Giga

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTAXXtp>; Fri, 24 Jan 2003 18:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTAXXtp>; Fri, 24 Jan 2003 18:49:45 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8186 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265863AbTAXXto> convert rfc822-to-8bit;
	Fri, 24 Jan 2003 18:49:44 -0500
content-class: urn:content-classes:message
Subject: RE: 2.5.59-mm5: cpu1 not working
Date: Fri, 24 Jan 2003 15:58:53 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DFEE8E7@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.59-mm5: cpu1 not working
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLEAggM91UFKC/0EdeNCQBQi+Bs2AAAhYsQ
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Arador" <diegocg@teleline.es>
Cc: <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 24 Jan 2003 23:58:53.0957 (UTC) FILETIME=[8CB7E350:01C2C404]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego,
  It also depends on the work load on cpus.
Regards,
Nitin

> btw, ping -f hits 24000-29000 int. per second; adding
> a cat /dev/hda slows it down to 20, 22000. Shouldn't
> it redistribute the interrupts in a way you get > 29000?
> (note that i've not idea of this thing)
> 
> 
> Diego Calleja

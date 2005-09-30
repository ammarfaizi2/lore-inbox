Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVI3WZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVI3WZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbVI3WZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:25:40 -0400
Received: from emulex.emulex.com ([138.239.112.1]:56463 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1030490AbVI3WZj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:25:39 -0400
From: James.Smart@Emulex.Com
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx intothe kernel
Date: Fri, 30 Sep 2005 18:25:22 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F46E1@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: I request inclusion of SAS Transport Layer and AIC-94xx intothe kernel
Thread-Index: AcXF+77lMB9Wof/VTXasvPPQZ2guegAEe+tg
To: <andrew.patterson@hp.com>, <luben_tuikov@adaptec.com>
Cc: <mark_salyzyn@adaptec.com>, <dougg@torque.net>, <torvalds@osdl.org>,
       <ltuikov@yahoo.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > > buffers limited to page size, etc.
> > 
> > "You have an attribute larger than 4k?  What is it?"
> 
> Not sure at the moment, can I guarantee this for the future?

FC wants to do NameServer queries, allow generic CT requests, etc.
Payload sizes are arbitrary, and can certainly be larger than 4k.
Also - payload must occur in both directions.

-- james 

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTG3WzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272314AbTG3WzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:55:19 -0400
Received: from fmr06.intel.com ([134.134.136.7]:62930 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S272313AbTG3WzQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:55:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: e1000 performance
Date: Wed, 30 Jul 2003 15:55:12 -0700
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E010222924C@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: e1000 performance
Thread-Index: AcNW6e1541fTWMtvSYaga00uwIQLEgAAyrzw
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Lista Linux-Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jul 2003 22:55:13.0310 (UTC) FILETIME=[A2AEABE0:01C356ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I am getting weird performace with e1000 in 2.4.22-pre.

Back to your original note: you say it's weird; what's your expectation?

> 0x00008: STATUS (Device status register) 0x00001B8F

You're running PCI 64-bit/66Mhz.  (ethtool 1.8 will tell you that by
decoding the STATUS bits ;-).

I thought maybe you were running at 32/33.

-scott

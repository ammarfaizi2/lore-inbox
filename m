Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTLKFGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTLKFGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:06:47 -0500
Received: from c-24-1-130-95.client.comcast.net ([24.1.130.95]:48741 "EHLO
	aruba.maner.org") by vger.kernel.org with ESMTP id S263537AbTLKFGq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:06:46 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Date: Wed, 10 Dec 2003 23:06:46 -0600
Message-ID: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Thread-Index: AcO/o9RHj9M76vDCT2yx5Hzp8rENvwAAEB7g
From: "Donald Maner" <donjr@maner.org>
To: "Raul Miller" <moth@magenta.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel you're using WAS compiled with CONFIG_HIGHMEM4G=y, correct?

-----Original Message-----
From: Raul Miller [mailto:moth@magenta.com] 
Sent: Wednesday, December 10, 2003 10:52 PM
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB
ram.


[1.] Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.

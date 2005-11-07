Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVKGH1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVKGH1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbVKGH1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:27:10 -0500
Received: from 64-128-31-104.gen.twtelecom.net ([64.128.31.104]:21425 "EHLO
	voyager-2003.ashleylaurent.com") by vger.kernel.org with ESMTP
	id S1750749AbVKGH1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:27:09 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: A dst_cache_overflow issue
Date: Mon, 7 Nov 2005 01:27:04 -0600
Message-ID: <586758F997454548B9EC83CC09B711673AD39D@voyager-2003.ashleylaurent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: A dst_cache_overflow issue
Thread-Index: AcXjbKa3BXJ3ZsrAQhWDb4wvHUR0hw==
From: "Joji Joseph" <jjoseph@ashleylaurent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

       Have you ever met a problem that "ip_dst_cache" is going beyond 8192 sometimes? After sometimes, I am getting the "dst_cache_overflow" messages and "out of memory" in the device.

  I am using Linux 2.4.17 with a BogoMips device. Please let me know that somebody had already faced this issue earlier and any solution found.

The traffic passing through the device is online audio/video sessions and Bit Torent sometimes.

Thank you very much in advance for all of your help/advice.

Thanks
Joji


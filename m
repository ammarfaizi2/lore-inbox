Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269819AbTGKH65 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 03:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269851AbTGKH65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 03:58:57 -0400
Received: from [195.143.77.242] ([195.143.77.242]:43743 "EHLO mail.tally.de")
	by vger.kernel.org with ESMTP id S269819AbTGKH6z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 03:58:55 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: linux 2.5.75 & I2C_PROC
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Fri, 11 Jul 2003 10:14:27 +0200
Message-ID: <97F6E34E67F1BA4B93F8C35F84D146620993B5@TGE-MAIL.tally.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux 2.5.75 & I2C_PROC
Thread-Index: AcNHhIGniAcah01rQQSyjMW2wpw5vQ==
From: "Kissner, Sven" <sven.kissner@tally.de>
To: <linux-kernel@vger.kernel.org>
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19at28-0000f2-00*dg8Udgai4Jw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm using linux 2.5.75 on my debian box and want to run lm_sensors. The
userspace apps (sensors-detect & sensors) require the module I2C_PROC,
which I can't find within the kernel configuration. Are there any
dependencies so I2C_PROC becomes available? I'm thankful for any
enlightment. 

For I'm not subscribed to the list, please cc me on reply.

Thanks in advance 
Sven


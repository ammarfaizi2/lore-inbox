Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUCKMwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCKMwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:52:02 -0500
Received: from [202.125.86.130] ([202.125.86.130]:35735 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261238AbUCKMwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:52:00 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: interruptible_sleep_on() from tasklet?
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Thu, 11 Mar 2004 18:18:15 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9721764AB@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: interruptible_sleep_on() from tasklet?
Thread-Index: AcQHZx7BguI8Mq3SRrO66s1dSWWG+Q==
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can we do interruptible_sleep_on or interruptible_sleep_on_timeout from a tasklet?

Regards,
-Jinu

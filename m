Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161052AbWJPUqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWJPUqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWJPUqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:46:48 -0400
Received: from ext-nj2ut-13.online-age.net ([64.14.54.246]:49980 "EHLO
	ext-nj2ut-13.online-age.net") by vger.kernel.org with ESMTP
	id S1161052AbWJPUqr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:46:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Bandwidth Allocations under CFQ I/O Scheduler
Date: Mon, 16 Oct 2006 16:46:41 -0400
Message-ID: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bandwidth Allocations under CFQ I/O Scheduler
Thread-Index: AcbxZC8MzG5yaZ/HRnu8ajOZQ6lUZA==
From: "Phetteplace, Thad \(GE Healthcare, consultant\)" 
	<Thad.Phetteplace@ge.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Oct 2006 20:46:44.0143 (UTC) FILETIME=[309FA3F0:01C6F164]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The I/O priority levels available under the CFQ scheduler are
nice (no pun in intended), but I remember some talk back when
they first went in that future versions might include bandwidth
allocations in addition to the 'niceness' style.  Is anyone out
there working on that?  If not, I'm willing to hack up a proof
of concept... I just wan't to make sure I'm not reinventing
the wheel.

Thanks,

Thad Phetteplace

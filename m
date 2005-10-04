Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbVJDMoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVJDMoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVJDMnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:05 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:25571 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932404AbVJDMm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:58 -0400
Date: Tue, 04 Oct 2005 14:41:26 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/7] more HPET fixes and enhancements
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124126.23057.75614.schnuffi@turing>
Content-transfer-encoding: 7BIT
X-Scan-Signature: de24556299d96d4a199f010d8c9778f2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another round of HPET bugfixes and cleanups.

 drivers/char/hpet.c |   35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

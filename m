Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbUKWQT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUKWQT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUKWQRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:17:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:25215 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261332AbUKWQOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:15 -0500
Cc: openib-general@openib.org
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:08 -0800
Message-Id: <20041123814.p0AnYzTlx42JeVes@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][0/21] Second submission of InfiniBand patches for review
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:14.0193 (UTC) FILETIME=[79704210:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the second version of the InfiniBand driver patch set.  These
patches incorporate most but not all of the feedback received since
Monday.  However, the main reason for posting this new set is that
several of the patches in the first batch ran afoul of the 100K limit
on linux-kernel.  This batch is split into smaller pieces so all the
parts should make it through this time.

Thanks,
  Roland Dreier
  OpenIB Alliance
  www.openib.org


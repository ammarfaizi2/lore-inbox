Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946732AbWJTAJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946732AbWJTAJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946735AbWJTAJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:09:25 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:29373 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946732AbWJTAJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:09:24 -0400
Date: Thu, 19 Oct 2006 17:09:04 -0700
Message-Id: <200610200009.k9K094As027552@zach-dev.vmware.com>
Subject: [PATCH 0/5] General cleanups for i386 from paravirt-ops work
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 20 Oct 2006 00:09:21.0726 (UTC) FILETIME=[FE58D5E0:01C6F3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more pre-paravirt cleanups and needed features, all
mostly harmless and benign.

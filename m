Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVC3Cwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVC3Cwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 21:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVC3Cwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 21:52:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25544 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261394AbVC3Cws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 21:52:48 -0500
From: gh@us.ibm.com
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net
Subject: [patch 0/8] CKRM:   Core patch set
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8224.1112059335.1@us.ibm.com>
X-Evolution: 00000008-0000
Date: Tue, 29 Mar 2005 18:52:46 -0800
Message-Id: <E1DGTK2-0007gO-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--

This is the core patch set for CKRM, review comments almost all
applied (there are a few we are still working on, mostly cosmetic).
However, this set has been extensively regression tested on IA32,
x86-64/EM64T, and PPC64, with various CKRM CONFIG options on and
off and both regression tests and ckrm's functional tests.

I believe this set is ready for additional testing in -mm.  We
have an additional 4 patch sets that will follow this (classification
engines, memory controller, IO controller, updated network controller).

Continued comments are welcome; once we have patches for the last
of the cleanups, we are hoping we'll have sufficient testing to be
able to push this towards mainline.

gerrit

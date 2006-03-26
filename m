Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWCZVHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWCZVHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWCZVHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:07:18 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:63462 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750976AbWCZVHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:07:16 -0500
Date: Sun, 26 Mar 2006 22:07:10 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>, <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org
Subject: Are ALL_TASKS_PI on in 2.6.16-rt7?
Message-ID: <Pine.LNX.4.44L0.0603262205320.8060-100000@lifa03.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It just looks like also normal, non-rt tasks are boosting.

Esben



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271405AbTG2LWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271407AbTG2LWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:22:32 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:50603 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271405AbTG2LWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:22:31 -0400
From: Miles Lane <miles.lane@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: Linus' 2.6.0-test1 (PPC) -- Radeon Mobility M7 LW (AGP) display messed up (DRI update problem?)
Date: Tue, 29 Jul 2003 04:22:29 -0700
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307290422.29999.miles.lane@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Disabling DRI fixed the problem, but now I find that the problem
goes back to at least 2.5.75.  I am going to keep going back until
I locate the patch that causes the failure.

	Miles

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUIVDJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUIVDJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 23:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUIVDJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 23:09:23 -0400
Received: from ares.cs.Virginia.EDU ([128.143.137.19]:57273 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id S267748AbUIVDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 23:09:22 -0400
Date: Tue, 21 Sep 2004 23:09:19 -0400 (EDT)
From: Ronghua Zhang <rz5b@cs.virginia.edu>
To: linux-kernel@vger.kernel.org
Subject: Does ZONE_HIGHMEM exist on machines with 1G memeory
Message-ID: <Pine.GSO.4.51.0409212305520.8395@mamba.cs.Virginia.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This may be a dumb question. But it seems to me that when the machine
has 1GB memory, it can be mapped to the 1GB kernel virtual address space.
Do we still need ZONE_HIGHMEM in this case? Please CC any follow-up to me.
Thanks

Ronghua

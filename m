Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTJBVzD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTJBVzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:55:03 -0400
Received: from bvds.geneva.edu ([63.172.29.191]:51417 "EHLO bvds.geneva.edu")
	by vger.kernel.org with ESMTP id S263517AbTJBVxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:53:46 -0400
From: <bvds@bvds.geneva.edu>
To: linux-kernel@vger.kernel.org
Cc: bvds@geneva.edu
Subject: segfault error on x86_64
Message-Id: <20031002215345.A1D33E24D6@bvds.geneva.edu>
Date: Thu,  2 Oct 2003 17:53:45 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have kernel 2.4.22 compiled with gcc 3.3 running on a 
dual AMD Opteron (in 64 bit mode).  
There is an error message that occurs about twice a day at random times:

Sep 30 23:45:00 gideon kernel: bumps[12960]: segfault at 0000002a95611000 rip 0000000000402150 rsp 0000007fbffff1a8 error 6
Oct  1 10:26:57 gideon kernel: bumps[13510]: segfault at 0000002a95611000 rip 0000000000402150 rsp 0000007fbffff1a8 error 6

As far as I can tell, there is no other effect than this message.
(the system keeps running OK).

What is "bumps" ?

BvdS

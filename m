Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3XCZ>; Thu, 30 Nov 2000 18:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQK3XCP>; Thu, 30 Nov 2000 18:02:15 -0500
Received: from fw-west.west.akamai.com ([63.102.156.130]:16381 "EHLO
	akamai.com") by vger.kernel.org with ESMTP id <S129257AbQK3XCB>;
	Thu, 30 Nov 2000 18:02:01 -0500
Date: Thu, 30 Nov 2000 14:36:05 -0800 (PST)
From: Rajeev Bector <rajeev@akamai.com>
To: linux-kernel@vger.kernel.org
Subject: using TOS as a key in route cache
Message-ID: <Pine.LNX.4.10.10011301433470.5925-100000@marjorie.sanmateo.akamai.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guys
 I am looking for a reason as to why we want
to have different route cache entries for
different IP ToS types. Does anyone have
any insight into this ?

thanks

-- Rajeev

(please cc replies to rajeev@akamai.com)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbTJKBBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 21:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbTJKBBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 21:01:49 -0400
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:58843 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S263196AbTJKBBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 21:01:49 -0400
Message-Id: <200310110101.KAA29159@toshiba.co.jp>
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: Matt Domsch <Matt_Domsch@dell.com>, Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, linux-megaraid-devel@dell.com
Subject: RE: megaraid2 compilation failure in 2.4
Date: Sat, 11 Oct 2003 10:00:26 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="shift_jis"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote;

> Looks like the "no host lock" patch didn't get submitted/applied.
>  2.4.x stock still uses io_request_lock.  

I think so.
When operating 2.4.xx, "no host lock" patch is surely required.
--
Haruo

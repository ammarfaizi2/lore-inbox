Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422636AbWJPPme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbWJPPme (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWJPPme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:42:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:16811 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161002AbWJPPmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:42:33 -0400
Subject: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Content-Type: text/plain
Date: Mon, 16 Oct 2006 08:42:18 -0700
Message-Id: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zach,


While looking at test.kernel.org failures, I noticed that most
of fsx tests with AIO or DIO (or combination) are failing.

I haven't digged deep, but I am assuming its something to do
with your latest cleanup work :(

Can you take a look ? Failures look nasty ..

http://test.kernel.org/abat/55567/005.fsx-linux.test/results/


Thanks,
Badari


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUCDJo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 04:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbUCDJo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 04:44:56 -0500
Received: from math.ut.ee ([193.40.5.125]:28302 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261628AbUCDJoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 04:44:55 -0500
Date: Thu, 4 Mar 2004 11:44:49 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: parport compile error in 2.6.4-r2c (sparc64)
Message-ID: <Pine.GSO.4.44.0403041144040.2398-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

drivers/parport/parport_sunbpp.c: In function `init_one_port':
drivers/parport/parport_sunbpp.c:338: warning: passing arg 2 of `request_irq' from incompatible pointer type
drivers/parport/parport_sunbpp.c: In function `parport_sunbpp_exit':
drivers/parport/parport_sunbpp.c:387: error: incompatible type for argument 1 of `list_empty'

-- 
Meelis Roos (mroos@linux.ee)


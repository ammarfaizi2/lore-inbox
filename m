Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265682AbUAMWHi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265687AbUAMWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:07:38 -0500
Received: from ns1.levanger.kommune.no ([62.148.55.130]:50445 "EHLO
	ns1.levanger.kommune.no") by vger.kernel.org with ESMTP
	id S265682AbUAMWH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:07:29 -0500
Message-ID: <1074031396.40046b2428b50@webmail.levangernett.no>
Date: Tue, 13 Jan 2004 23:03:16 +0100
From: martin@linuxnerds.net
To: linux-kernel@vger.kernel.org
Subject: ide driver from 2.4 to 2.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1 / FreeBSD-4.8
X-Originating-IP: 129.241.130.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have recently purchased the highpoint rocketraid 1540, which comes with a 
driver. It wount compile in 2.6.1, which is understandable. I tried the promise 
open source driver, which results in a similar error, somewhere in the irq-
system (irq.h).

Now the question is, would it be a accomplishable task for me to fix this, and 
what are the differences from the old to the new one, and what must i watch out 
for?

Anyone familiar to the changes it has been through?

Thanks, Martin.

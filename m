Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTB0FWS>; Thu, 27 Feb 2003 00:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTB0FWS>; Thu, 27 Feb 2003 00:22:18 -0500
Received: from syr-24-92-237-98.twcny.rr.com ([24.92.237.98]:26365 "EHLO
	server.foo") by vger.kernel.org with ESMTP id <S261290AbTB0FWR>;
	Thu, 27 Feb 2003 00:22:17 -0500
Date: Thu, 27 Feb 2003 00:32:27 -0500
From: Dan Maas <dmaas@maasdigital.com>
To: linux-kernel@vger.kernel.org
Subject: Ping-pong on Hyperthread CPUs?
Message-ID: <20030227003227.A23919@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed that processes tend to ping-ping between the two
virtual CPUs in my Hyperthreaded P4 machine (kernel 2.4.20). I know
this would be bad on true SMP systems, but does it have any impact
with Hyperthread CPUs? Should I be worried?

Also, hardware interrupts all seem to be going to the first virtual
CPU. I assume this is intentional.

Thanks,
Dan

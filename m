Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUHDFna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUHDFna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUHDFn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:43:29 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:29111 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S267263AbUHDFn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:43:28 -0400
X-Qmail-Scanner-Mail-From: solt@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.22 (Clear:RC:0(150.254.37.14):SA:0(0.0/5.0):. Processed in 3.324097 secs)
Date: Wed, 4 Aug 2004 07:43:26 +0200
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Mailer: SecureBat! Lite (v2.10.02) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <34840234.20040804074326@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/3] Scheduler policies for staircase
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

I have been using SCHED_BATCH on two machines now with expected
results. So this you might consider this as another success report :-)

Do you think that these schedulers could come into the mainline
soon? Would you submit them to Linus without the staircase scheduler
or would you rather wait for the whole bunch of changes to get
rock-stable ?

Best regards,
Maciej



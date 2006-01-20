Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWATSZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWATSZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWATSZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:25:22 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:49633 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751136AbWATSZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:25:21 -0500
Subject: 2.6.15-rt6: network driver disabled interrupts: skge_xmit_frame
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:25:10 -0800
Message-Id: <1137781510.18253.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tons of these messages when I try out the skge network driver under
2.6.15-rt6 (instead of the sk98lin driver):

  network driver disabled interrupts: skge_xmit_frame+0x0/0x330 [skge]

Any fixes I could try?
Thanks...
-- Fernando



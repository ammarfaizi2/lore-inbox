Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbTI3Qr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTI3Qr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:47:59 -0400
Received: from main.gmane.org ([80.91.224.249]:65434 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261291AbTI3Qr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:47:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Schwarz <usenet.2117@andreas-s.net>
Subject: Re: Call traces due to lost IRQ
Date: Tue, 30 Sep 2003 16:47:56 +0000 (UTC)
Message-ID: <slrnbnjcu8.43n.usenet.2117@home.andreas-s.net>
References: <20030930154032.GA795@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Pitt wrote:
> [1.] Kernel boot yields lost IRQ with some call traces
>
> [2.] When booting 2.6.0-test6, the following message appears:
>
> 	------------- snip -------------
> 	irq 12: nobody cared!
> 	Call Trace:
> 	 [<c010b5ca>] __report_bad_irq+0x2a/0x90
> 	 [<c010b6bc>] note_interrupt+0x6c/0xa0

I've got the same messages (2.6.0-test6-mm1).

-- 
AVR-Tutorial, über 350 Links
Forum für AVRGCC und MSPGCC
-> http://www.mikrocontroller.net


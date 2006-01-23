Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWAWRW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWAWRW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWAWRW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:22:57 -0500
Received: from mx1.slu.se ([130.238.96.70]:33739 "EHLO mx1.slu.se")
	by vger.kernel.org with ESMTP id S964837AbWAWRW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:22:57 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17365.3002.480408.154987@robur.slu.se>
Date: Mon, 23 Jan 2006 18:00:42 +0100
To: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Cc: davem <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, robert.olsson@its.uu.se
Subject: [PATCH 00/00] pktgen: refinements and small fixes.
In-Reply-To: <20060123134140.b04ad994.lcapitulino@mandriva.com.br>
References: <20060123134140.b04ad994.lcapitulino@mandriva.com.br>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luiz Fernando Capitulino writes:

 >  [PATCH 00/02] pktgen: Ports thread list to Kernel list implementation.
 >  [PATCH 00/03] pktgen: Fix kernel_thread() fail leak.
 >  [PATCH 00/04] pktgen: Fix Initialization fail leak. 
 > 

 >  But I'm sending these patches first, just to know if I'm doing something
 > wrong.

 Thanks!

 Looks interesting. Yes of course better to use kernel list functions. I'll 
 patch my lab version and run through some tests. 
 
 Yes keep on hacking...

 Cheers.
					--ro

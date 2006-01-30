Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWA3LS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWA3LS0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWA3LSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:18:25 -0500
Received: from mx1.slu.se ([130.238.96.70]:8842 "EHLO mx1.slu.se")
	by vger.kernel.org with ESMTP id S932217AbWA3LSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:18:24 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17373.62964.203852.42375@robur.slu.se>
Date: Mon, 30 Jan 2006 12:18:12 +0100
To: davem <davem@davemloft.net>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: [PATCH 0/4] - pktgen: refinements and small fixes (V2).
In-Reply-To: <20060129232342.1e481f9a@localhost>
References: <20060129232342.1e481f9a@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luiz Fernando Capitulino writes:

 > [PATCH 1/4]  pktgen: Lindent run.
 > [PATCH 2/4]  pktgen: Ports thread list to Kernel list implementation.
 > [PATCH 3/4]  pktgen: Fix kernel_thread() fail leak.
 > [PATCH 4/4]  pktgen: Fix Initialization fail leak.
 > 
 >  The changes from V1 are:
 > 
 >  1. More fixes made by hand after Lindent run
 >  2. Re-diffed agains't Dave's net-2.6.17 tree

 Should be fine I've used the previous version of the patches for a
 couple of days now. Thanks.

 Signed-off-by: Robert Olsson <robert.olsson@its.uu.se>

 Cheers.	
					--ro

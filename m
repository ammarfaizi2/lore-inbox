Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUCRQaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUCRQaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:30:00 -0500
Received: from aun.it.uu.se ([130.238.12.36]:15079 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262006AbUCRQ37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:29:59 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16473.52851.367709.934661@alkaid.it.uu.se>
Date: Thu, 18 Mar 2004 17:29:39 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip (pnic) errors in 2.6.5-rc1
In-Reply-To: <40597E68.7090908@pobox.com>
References: <16473.28514.341276.209224@alkaid.it.uu.se>
	<40597123.8020903@pobox.com>
	<405971B3.3080700@pobox.com>
	<16473.32039.160055.63522@alkaid.it.uu.se>
	<40597E68.7090908@pobox.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > Jeff Garzik writes:
 > >  > er, oops... lemme find the right patch...
 > > 
 > > No change, still a flood of those tulip_rx() interrupt messages.
 > 
 > hmmm.  Well, it is something unrelated to tulip driver, then.

Testing older -bk versions I've found that 2.6.4-bk2
is Ok but 2.6.4-bk3 has this message flood problem.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTJ1IXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 03:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTJ1IXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 03:23:51 -0500
Received: from main.gmane.org ([80.91.224.249]:432 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263873AbTJ1IXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 03:23:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: Re: status of ipchains in 2.6?
Date: Tue, 28 Oct 2003 09:23:48 +0100
Message-ID: <bnl92k$iae$2@sea.gmane.org>
References: <200310280127.h9S1RM5d002140@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Unlike ipchains, iptables works perfectly fine, so perhaps we just
> need to update Kconfig to discourage ipchains on ia64 (and/or other
> 64-bit platforms)?

Perhaps we simply drop ipchains support for good?

-- 
Try Linux 2.6 from BitKeeper for PXA2x0 CPUs at
http://www.mn-logistik.de/unsupported/linux-2.6/


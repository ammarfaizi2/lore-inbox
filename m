Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWJWA1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWJWA1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWJWA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:27:48 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:62041 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750955AbWJWA1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:27:47 -0400
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Avi Kivity <avi@qumranet.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
X-Message-Flag: Warning: May contain useful information
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de>
	<453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de>
	<1161547168.1919.38.camel@localhost.localdomain>
	<p7364ecm1cl.fsf@verdi.suse.de>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 22 Oct 2006 17:27:45 -0700
In-Reply-To: <p7364ecm1cl.fsf@verdi.suse.de> (Andi Kleen's message of "23 Oct 2006 00:28:58 +0200")
Message-ID: <adahcxvj2pq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Oct 2006 00:27:45.0750 (UTC) FILETIME=[0FA2C760:01C6F63A]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Ah you're right. I forgot about the Yonahs. The number is probably
 > not even that small (when Intel ships something x86 they tend to 
 > do it in millions)

Right, it's quite a mainstream CPU -- for example every current
Thinkpad has one I think.  And lots of kernel hackers tend to care
about making things work on a Thinkpad (except for akpm and his
precious vaio :).

 - R.

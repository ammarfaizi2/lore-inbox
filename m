Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUHZEzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUHZEzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUHZEzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:55:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:17873 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267583AbUHZEzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:55:18 -0400
Date: Wed, 25 Aug 2004 21:44:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Andrew Walrond" <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Oops; HPET related
Message-Id: <20040825214425.7d2fce71.rddunlap@osdl.org>
In-Reply-To: <000001c48769$0c4aefd0$74e7183e@MEK1>
References: <000001c48769$0c4aefd0$74e7183e@MEK1>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 11:24:31 +0100 Andrew Walrond wrote:

| Unless I boot with hpet=disabled, the kernel gets to...
| 
| Using hpet for high-res timesource
| Calibrating delay loop...
| 
| And sits here for a few minutes, then oopses (jpg attached). This is
| 100% reproducible.
| 
| This is a Tyan K8W dual Opteron m/b running a vanilla 2.6.8.1 kernel
| compiled 32bit for K8 with smp and preempt. HPET is enabled in the
| (latest) BIOS
| 
| Anything else I can supply, let me know.

Still a problem?  If so, please send a complete kernel boot log.

--
~Randy

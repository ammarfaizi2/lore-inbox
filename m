Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTLDTxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLDTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:53:36 -0500
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.160]:45963 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id S263388AbTLDTxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:53:35 -0500
X-Biglobe-Sender: <slee@muf.biglobe.ne.jp>
Date: Fri, 05 Dec 2003 04:53:33 +0900
From: Stephen Lee <mukansai@emailplus.org>
To: "Feldman, Scott" <scott.feldman@intel.com>
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Cc: "Harald Welte" <laforge@netfilter.org>,
       <netfilter-devel@lists.netfilter.org>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD21@orsmsx402.jf.intel.com>
Message-Id: <20031205045020.4C0E.MUKANSAI@emailplus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Feldman, Scott" <scott.feldman@intel.com> wrote:
> 
> TSO is support on 82540.  Turning off TSO is a workaround, but what's
> behind the dependency of TSO and ip_conntrack?  You indicated in an
> earlier note that having the ip_conntrack module loaded was a factor.
> Do you have a nic to try with tg3?  I believe tg3 has TSO enabled as
> well (in 2.6.0-test11).

I have a 32-bit PCI card with bcm5705 on it, does that support TSO? 
I'll give it a try today.

Stephen


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVBOSla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVBOSla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVBOSl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:41:29 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61870
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261814AbVBOSkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:40:55 -0500
Date: Tue, 15 Feb 2005 10:38:23 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, tony.luck@intel.com,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] Consolidate the last compat sigvals
Message-Id: <20050215103823.3b418cba.davem@davemloft.net>
In-Reply-To: <20050215154648.74e54fff.sfr@canb.auug.org.au>
References: <20050215154648.74e54fff.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005 15:46:48 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This patch just consolidates the last of the (what should have been)
> compat_sigval_ts.  It worries me that S390 has a sigval_t in its struct
> compat_siginfo, but I have left that for now.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

This one looks good too.

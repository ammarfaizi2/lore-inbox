Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVCXFpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVCXFpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 00:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVCXFpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 00:45:42 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:39654
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263043AbVCXFpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 00:45:32 -0500
Date: Wed, 23 Mar 2005 21:44:38 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, akpm@osdl.org, tony.luck@intel.com,
       benh@kernel.crashing.org, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
Message-Id: <20050323214438.685a48f9.davem@davemloft.net>
In-Reply-To: <42420928.7040502@yahoo.com.au>
References: <Pine.LNX.4.61.0503231705560.15274@goblin.wat.veritas.com>
	<20050323115736.300f34eb.davem@davemloft.net>
	<42420928.7040502@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 11:26:16 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> OK, attached is my first cut at slimming down the boundary tests.

Works perfectly fine on sparc64.

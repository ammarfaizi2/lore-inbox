Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVCRU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVCRU42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 15:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCRU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 15:56:28 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:58317
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261338AbVCRU40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 15:56:26 -0500
Date: Fri, 18 Mar 2005 12:56:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@osdl.org,
       wli@holomorphy.com, riel@redhat.com, kurt@garloff.de,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH 0/4] io_remap_pfn_range: intro.
Message-Id: <20050318125617.5e57c3f8.davem@davemloft.net>
In-Reply-To: <20050318112545.6f5f7635.rddunlap@osdl.org>
References: <20050318112545.6f5f7635.rddunlap@osdl.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 11:25:45 -0800
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> The sparc32 & sparc64 code needs live testing.

These patches look great Randy.  I think they should go in.

If sparc explodes, I'll clean up the mess.  Any problem which
crops up should not be difficult to solve.

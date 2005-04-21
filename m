Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVDVAG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVDVAG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDVAG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:06:56 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17085
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261748AbVDVAGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:06:50 -0400
Date: Thu, 21 Apr 2005 16:59:56 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 3/10] tg3: add bcm5752 entry to pci_ids.h
Message-Id: <20050421165956.55bdcb14.davem@davemloft.net>
In-Reply-To: <04132005193844.8474@laptop>
References: <04132005193844.8410@laptop>
	<04132005193844.8474@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:44 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Add proper entry for bcm5752 PCI ID to pci_ids.h, and use it in tg3.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> I did this separately in case patches like this (i.e. new PCI IDs)
> need to come from more "official" sources.

Applied, thanks.  Don't we need a drivers/pci/pci.ids update as
well?

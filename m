Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVDVAOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVDVAOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDVANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:13:10 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:32930
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261749AbVDVALv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:11:51 -0400
Date: Thu, 21 Apr 2005 17:04:57 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 10/10] tg3: add support for bcm5752 rev a1
Message-Id: <20050421170457.3e49665c.davem@davemloft.net>
In-Reply-To: <04132005193846.8893@laptop>
References: <04132005193846.8835@laptop>
	<04132005193846.8893@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:46 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Replace existing ASIC_REV_5752 definition with ASIC_REV_5752_A0,
> and add definition for ASIC_REV_5752_A1. Then, add ASIC_REV_5752_A1
> to check for setting TG3_FLG2_5750_PLUS in tg3_get_invariants.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Applied, now off to Michael's additions :-)

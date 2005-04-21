Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVDVAEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVDVAEh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDVAEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:04:30 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:14013
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261732AbVDVAE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:04:27 -0400
Date: Thu, 21 Apr 2005 16:57:29 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 1/10] tg3: add basic bcm5752 support
Message-Id: <20050421165729.27c0b6ad.davem@davemloft.net>
In-Reply-To: <04132005193843.8351@laptop>
References: <04132005193843.8300@laptop>
	<04132005193843.8351@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:43 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Track-down all references to ASIC_REV_5750 and mirror them with
> references to the newly defined ASIC_REV_5752.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

You don't actually add the ASIC_REV_5752 definition to tg3.h,
but I took care of that for you when checking this patch in.

Applied, thanks.

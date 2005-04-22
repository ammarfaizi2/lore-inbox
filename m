Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVDVAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVDVAOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDVANV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:13:21 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:31650
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261770AbVDVAK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:10:58 -0400
Date: Thu, 21 Apr 2005 17:04:00 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 9/10] tg3: check TG3_FLG2_5750_PLUS flag to
 set TG3_FLG2_5705_PLUS flag
Message-Id: <20050421170400.6a6fd892.davem@davemloft.net>
In-Reply-To: <04132005193846.8835@laptop>
References: <04132005193845.8775@laptop>
	<04132005193846.8835@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:46 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Use check of TG3_FLG2_5750_PLUS in tg3_get_invariants to set
> TG3_FLG2_5705_PLUS flag.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Applied.

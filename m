Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVDVANB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVDVANB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDVAKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:10:55 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:30370
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261770AbVDVAKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:10:22 -0400
Date: Thu, 21 Apr 2005 17:03:23 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 8/10] tg3: use TG3_FLG2_57{05,50}_PLUS flags
 in tg3_get_invariants
Message-Id: <20050421170323.64e19505.davem@davemloft.net>
In-Reply-To: <04132005193845.8775@laptop>
References: <04132005193845.8720@laptop>
	<04132005193845.8775@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:45 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Rewrite checks in tg3_get_invariants to use TG3_FLG2_5705_PLUS and
> TG3_FLG2_5750_PLUS flags.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Applied.

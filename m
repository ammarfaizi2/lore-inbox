Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVDVAKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVDVAKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDVAJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:09:07 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:18365
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261749AbVDVAHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:07:38 -0400
Date: Thu, 21 Apr 2005 17:00:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 4/10] tg3: use TG3_FLG2_5705_PLUS instead of
 multi-way if's
Message-Id: <20050421170043.6845519a.davem@davemloft.net>
In-Reply-To: <04132005193844.8539@laptop>
References: <04132005193844.8474@laptop>
	<04132005193844.8539@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:44 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Replace a number of three-way if statements checking for 5705, 5750,
> and 5752 to reference the equivalent TG3_FLG2_5705_PLUS flag instead.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Applied.

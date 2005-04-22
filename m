Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVDVANA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVDVANA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDVALS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:11:18 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:27554
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261749AbVDVAJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:09:10 -0400
Date: Thu, 21 Apr 2005 17:02:12 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: [patch 2.6.12-rc2 6/10] tg3: use new TG3_FLG2_5750_PLUS flag
Message-Id: <20050421170212.7245acb8.davem@davemloft.net>
In-Reply-To: <04132005193845.8656@laptop>
References: <04132005193845.8597@laptop>
	<04132005193845.8656@laptop>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2005 19:38:45 -0400
"John W. Linville" <linville@tuxdriver.com> wrote:

> Replace a number of two-way if statements checking for 5750, and/or
> 5752 to reference the newly-defined TG3_FLG2_5750_PLUS flag instead.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Applied.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVDAESy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVDAESy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVDAESy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:18:54 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:32667
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262601AbVDAESv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:18:51 -0500
Date: Thu, 31 Mar 2005 20:18:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Roland Dreier <roland@topspin.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][1/3] IPoIB: set skb->mac.raw on receive
Message-Id: <20050331201817.64fe1b69.davem@davemloft.net>
In-Reply-To: <20053311936.983q6QLaPvAkIcQj@topspin.com>
References: <20053311936.983q6QLaPvAkIcQj@topspin.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland, netdev@oss.sgi.com CC:'ing either Jeff Garzik and
myself, please.

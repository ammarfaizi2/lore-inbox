Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbUKRWe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUKRWe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261182AbUKRWdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 17:33:17 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:20625
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261170AbUKRW3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 17:29:55 -0500
Date: Thu, 18 Nov 2004 14:14:08 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com, greearb@candelatech.com, vlan@scry.wanfear.com
Subject: Re: [patch netdev-2.6] vlan_dev: return 0 on vlan_dev_change_mtu
 success
Message-Id: <20041118141408.686e7b16.davem@davemloft.net>
In-Reply-To: <20041118140436.A16007@tuxdriver.com>
References: <20041118140436.A16007@tuxdriver.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 14:04:36 -0500
"John W. Linville" <linville@tuxdriver.com> wrote:

> The VLAN net driver needs to return 0 from vlan_dev_change_mtu()
> on success.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Both 2.4.x and 2.6.x variants applied, thanks John.
